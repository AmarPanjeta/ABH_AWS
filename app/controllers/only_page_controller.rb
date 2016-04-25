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
    raise
    Awservice.create_server(params[:server])
    redirect_to root_path
  end

  def json_list
    slist=[]
    Awservice.serverList.each do |s|
      slist<<{id:s.id,state:s.state}
    end
    render json: slist
  end
end
