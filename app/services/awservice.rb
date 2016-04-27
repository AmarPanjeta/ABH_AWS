class Awservice
  include Fog

  def self.serverList
    make_connection.servers
  end

  def self.createServer(image_id)
    s=make_connection.servers.create(image_id: image_id,key_name: "master_key",security_group_ids:["sg-30be9d57"])
    return s
  end

  def self.stopServer(server_id)
    s=make_connection.servers.get(server_id).stop
  end

  def self.startServer(server_id)
    make_connection.servers.get(server_id).start
  end

  def self.install_puppet(server_id)
    server=make_connection.servers.get(server_id)
    Net::SSH.start(server.dns_name,"ubuntu",keys:"C:/Users/Amar/.ssh/master_key.pem") do |ssh|
      ssh.open_channel do |channel|
        channel.on_data do |channel,data|
          puts "#{data}"
            channel.send_data "Y\n" if data =~ /Y\/n/
            channel.send_data "y\n" if data=~ /y\/N/
          end

          channel.on_close do |ch|
            puts "Channel is closing!"
          end
          channel.request_pty
          channel.exec("sudo apt-get install puppet-common")
          channel.wait

          channel.close
      end
      output=ssh.exec!("puppet")
      puts output
      output=ssh.exec!("puppet")
      puts output
    end
  end

  def self.puppet_script(server_id,what)
    server=make_connection.servers.get(server_id)
    ssh=Net::SSH.start(server.dns_name,"ubuntu",keys:"#{ENV['HOME']}/.ssh/#{server.key_name}.pem")
    paramtrized=what.gsub(/'/,%q(\\\'))
    paramtrized=paramtrized.gsub(/"/,%q(\\\"))
    output=ssh.exec!("cd /tmp;echo -e \"#{paramtrized}\" > what.pp")
    ssh.close
    return output
  end

  private

  def self.make_connection
    return Compute.new({provider:"AWS",aws_access_key_id: ENV['AKEY'], aws_secret_access_key: ENV['SKEY'], region:"us-west-2"})
  end
end
