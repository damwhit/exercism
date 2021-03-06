class Element
  attr_accessor :next
  attr_reader :datum

  def initialize(datum)
    @datum = datum
    @next = nil
  end
end

class SimpleLinkedList
  def initialize(data = [])
    @head = nil
    @current_node = nil
    @arr = []
    data = data.to_a if data.class == Range
    return if data.empty?

    data.map { |e| push(Element.new(e)) }
  end

  def push(element)
    @head = element if @head.nil?
    traverse
    @current_node.next = element if @current_node != element
    self
  end

  def pop
    return nil if @head.nil?

    @current_node = @head
    until @current_node.next.nil?
      prev_node = @current_node
      @current_node = @current_node.next
    end
    prev_node.next = nil if prev_node
    @current_node
  end

  def to_a
    traverse(true) unless @head.nil?
    @arr
  end

  def reverse!
    @current_node = @head
    previous_node = nil
    until @current_node.nil?
      next_node = @current_node.next
      @current_node.next = previous_node
      previous_node = @current_node
      @head = @current_node if next_node.nil?
      @current_node = next_node
    end
    self
  end

  private

  def traverse(should_add = false)
    @current_node = @head
    until @current_node.next.nil?
      add if should_add
      @current_node = @current_node.next
    end
    add if @current_node.next.nil? && should_add
  end

  def add
    @arr.unshift @current_node.datum
  end
end
