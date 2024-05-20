require 'securerandom'
require 'classes/ticket'

class Client
  class << self
    def create_client(queue)
      client = new
      ticket = client.request_ticket(queue)
      ticket.assign_client(client.id)
      client
    end
  end

  attr_reader :id, :ticket

  def initialize
    @id = SecureRandom.uuid
    @ticket = nil
  end

  def request_ticket(queue)
    queue.mutex.synchronize do
      @ticket = queue.add_item
    end
  end
end
