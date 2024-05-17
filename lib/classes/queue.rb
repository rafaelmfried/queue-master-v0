class BlockingQueue
  class << self
    def create_queue
      new
    end
  end

  private_class_method :new

  attr_reader :tickets

  def initialize
    @queue = Array.new
    @mutex = Mutex.new
    @item_available = ConditionVariable.new
  end

  def add_item(item)
    @mutex.synchronize do
      @queue.push(item)
      @item_available.signal
    end
    ticket
  end

  def remove_item
    @mutex.synchronize do
      while @queue.empty?
        @item_available.wait(@mutex) while @queue.empty?
        @queue.shift
      end
    end
  end

  def empty?
    @mutex.synchronize { @queue.nil? || @queue.empty? }
  end
end
