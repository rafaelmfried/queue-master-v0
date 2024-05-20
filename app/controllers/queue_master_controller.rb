class QueueMasterController < ApplicationController
  def create
    name = params[:name]
    queue = Queue.find_by(name: name) || Queue.new(name: name)
    queue.save!
    render json: queue, status: :created
  end

  def get
    name = params[:name]
    queue = Queue.find_by(name: name)
    if queue
      render json: queue, status: :ok
    else
      render json: { error: 'Queue not found' }, status: :not_found
    end
  end
end