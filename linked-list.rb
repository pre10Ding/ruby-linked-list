# frozen_string_literal: true

# singly linked list class
class LinkedList
  require './node'
  # initialize can take an array of values and initialized a linked list with them
  def initialize(array_of_values = nil)
    @head = Node.new(:head, nil)
    @size = array_of_values.nil? ? 0 : array_of_values.length
    # if array_of_values != nil, call initialize_with_array(array_of_values)
  end

  def append(value)
    grow
    tail.next = Node.new(value, nil)
  end

  def prepend(value)
    grow
    @head.next = Node.new(value, @head.next)
  end

  attr_reader :head, :size

  def tail
    curr_node = @head
    curr_node = curr_node.next until curr_node.next.nil?
    curr_node
  end

  def at(index)
    check_index(index)
    at_private(index)
  end

  def pop
    curr_node = @head.next
    prev_node = @head
    until curr_node.next.nil?
      prev_node = curr_node
      curr_node = curr_node.next
    end
    prev_node.next = nil
    shrink
    curr_node # return the removed node
  end

  def contains?(value)
    curr_node = @head.next
    until curr_node.nil?
      return true if curr_node.value.eql? value

      curr_node = curr_node.next
    end
    false
  end

  def find(value)
    index = 0
    curr_node = @head.next
    until curr_node.nil?
      return index if curr_node.value.eql? value

      index += 1
      curr_node = curr_node.next
    end
    nil
  end

  def to_s
    curr_node = @head.next
    result = ''
    until curr_node.nil?
      result += "( #{curr_node.value} ) -> "
      curr_node = curr_node.next
    end
    "#{result}nil\n"
  end

  def insert_at(value, index)
    check_index(index)
    prev_node = at_private(index - 1)
    next_node = prev_node.next
    grow
    prev_node.next = Node.new(value,next_node)
  end

  def remove_at(index)
    check_index(index)
    prev_node = at_private(index - 1)
    next_node = prev_node.next
    prev_node.next = next_node.next
    shrink
    next_node # return the deleted node
  end

  private

  def grow
    @size += 1
  end

  def shrink
    @size -= 1
  end

  def at_private(index)
    curr_node = @head
    (index + 1).times { curr_node = curr_node.next } # index + 1 to avoid returning the head node
    curr_node
  end

  def check_index(index)
    raise 'Invalid index' if index.negative? || index > size
  end
end

ll = LinkedList.new
p ll
p ll.append('hello')
ll.append('world')
ll.append('!!')
ll.append('~')
p ll
ll.prepend('START')
p ll
p ll.size
# p ll.at(-1) #=> error
p ll.at(0)
p ll.at(1)
p ll.at(2)
p ll.at(3)
p ll.pop
p ll
p ll.contains?('hello')
p ll.find('hello')
p ll.find('NOT FOUND')
puts ll
p ll.insert_at('to', 2)
p ll.insert_at('the', 3)
puts ll
p ll.insert_at('BEGIN', 0)
puts ll
# p ll.insert_at('error', 13) #=> error
p ll.remove_at(2)
p ll.remove_at(4)
puts ll
