class OnlyPageController < ApplicationController

  def only_page
    @nesto=Awservice.serverList
  end

  def stop_server
    Awservice.stopServer(params[:server_id])
    render json: 1
  end

  def start_server
    Awservice.startServer(params[:server_id])
    render json: 1
  end

  def new_server
    @images=Image.all
  end

  def create_server
    @server=Awservice.createServer("ami-9dbea4fc")
    render json: @server
  end

  def install_puppet
    Awservice.install_puppet(params[:server_id])
  end


  def run_puppet_script
    Awservice.puppet_script(params[:server_id],params[:what])
    render json: 1
  end

  def json_list
    slist=[]
    Awservice.serverList.each do |s|
      slist<<{id:s.id,state:s.state}
    end
    render json: slist
  end
end
