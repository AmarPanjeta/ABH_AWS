class Awservice
  include Fog

  def self.serverList
    make_connection.servers
  end

  def self.createServer(image_id)
    s=make_connection.servers.create(image_id: image_id,key_name: "testinstance")
  end

  def self.stopServer(server_id)
    s=make_connection.servers.get(server_id).stop
  end

  def self.startServer(server_id)
    make_connection.servers.get(server_id).start
  end

  private

  def self.make_connection
    return Compute.new({provider:"AWS",aws_access_key_id: ENV['AKEY'], aws_secret_access_key: ENV['SKEY'], region:"us-west-2"})
  end
end
