require 'securerandom'

class Ticket
  class << self
    def generate_ticket
      new
    end
  end
  
  attr_reader :id, :created_at, :completed_at, :client_id, :attendant_id

  def initialize
    @id = SecureRandom.uuid
    @created_at = Time.now
    @completed_at = nil
    @client_id = nil
    @attendant_id = nil
  end

  def assign_client(client_id)
    @client_id = client_id    
  end

  def assign_attendant(attendant_id)
    @attendant_id = attendant_id
  end

  def mark_complete
    @completed_at = Time.now
  end
end
