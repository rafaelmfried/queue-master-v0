require 'classes/queue_master'
require 'classes/queue'
require 'classes/client'
require 'classes/attendant'
require 'thread'

class TicketController < ApplicationController
  before_action :set_queue_master

  def create
    name = params[:name]
    queue = @queue_master.get_queue(name)
    @ticket = queue.add_ticket
    if @ticket.save
      render :show, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

  def set_queue
    @queue_master = QueueMaster.create_queue
  end
end
