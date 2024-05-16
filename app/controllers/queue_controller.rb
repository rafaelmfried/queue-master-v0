require 'classes/queue_master'
require 'classes/queue'
require 'classes/client'
require 'classes/attendant'
require 'thread'

class QueueController < ApplicationController
  def index
    queue = Queue.new
    mutex = Mutex.new

    client_array = []

    # Thread para adicionar clientes à fila
    client_thread = Thread.new do
      100.times do
        client = nil
        mutex.synchronize { client = Client.create_client(queue) }
        client_array.add(client) if client
      end
    end

    # Threads para os atendentes
    attendant_threads = Array.new(2) do
      Thread.new do
        attendant = Attendant.create_attendant
        loop do
          ticket = nil
          mutex.synchronize { ticket = attendant.request_ticket(queue) unless queue.empty? }
          attendant.request_ticket if ticket
        end
      end
    end

    # Aguardar a conclusão das threads
    client_thread.join
    attendant_threads.each(&:join)

    render plain: "Teste de inclusão do diretório lib bem-sucedido!"
  end
end
