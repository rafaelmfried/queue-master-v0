class QueueMasterController < ApplicationController
  def create
    name = params[:name]
    queue_master = QueueMaster.new
    queue_master.create_queue(name)
    render json: { message: 'Queue created successfully', name: name }, status: :created
  end

  def get
    name = params[:name]
    queue_master = QueueMaster.new
    queue = queue_master.get_queue(name)
    if queue
      render json: queue, status: :ok
    else
      render json: { error: 'Queue not found' }, status: :not_found
    end
  end
end
