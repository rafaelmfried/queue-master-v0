require 'securerandom'

class Attendant
  class << self
    def create_attendant
      new
    end
  end

  attr_reader :id

  private_class_method :new

  def initialize
    @id = SecureRandom.uuid
    @mutex = Mutex.new
  end

  def request_ticket(queue)
    ticket = nil
    queue.mutex.synchronize { ticket = queue.remove_ticket }
    serve_client(ticket) if ticket
  end

  def serve_client(ticket)
    @mutex.synchronize do
      puts "Attendant ##{id} with ticket ##{ticket.id}"
      sleep(rand(1..10)) # Simula tempo do atendimento
      ticket.assign_attendant(id)
      ticket.mark_complete
      puts "Attendant ##{id}. Ticket completed in ##{client.ticket.completed_at - client.ticket.created_at}"
      
    end
  end
end
