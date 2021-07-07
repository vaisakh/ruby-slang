class TStack
  attr_reader :stack
  attr_reader :length

  def initialize
    @stack = Array.new(256)
    @length = 0
  end

  def clear
    @length = 0
  end

  def push element
    raise Exception.new "Stack overflow" if is_full?

    @stack.push(element)
    @length += 1
  end

  def pop
    raise Exception.new "Stack is empty" if is_empty?
    value = @stack.pop
    @length -= 1
    value
  end

  def is_full?
    @length === 256
  end

  def is_empty?
    @length.nil?
  end
end