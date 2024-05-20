class AttendantController < ApplicationController
  before_action :set_queue_master

  def show
    name = params[:name]
    queue = @queue_master.get_queue(name)
    @ticket = queue.next_ticket
    if @ticket
      render :show, status: :ok
    else
      render json: { error: 'No tickets available' }, status: :not_found
    end
  end

  private

  def set_queue_master
    @queue_master = QueueMaster.new
  end
end
