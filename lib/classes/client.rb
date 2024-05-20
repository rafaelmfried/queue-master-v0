require 'securerandom'
require 'classes/ticket'

class Client
  class << self
    def create_client(queue)
      client = new
      client.request_ticket(queue)
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
      @ticket = queue.add_ticket
    end
  end
end
