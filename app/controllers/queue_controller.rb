class QueueController < ApplicationController
  before_action :set_queue

  def show
    @ticket = @queue.next_ticket
    if @ticket
      render :show, status: :ok
    else
      render json: { error: 'No tickets available' }, status: :not_found
    end
  end

  private

  def set_queue
    @queue = TicketQueue.create_queue
  end
end
