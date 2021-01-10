# frozen_string_literal: true

# singly linked list node class
class Node
  def initialize(value = nil, next_node_ref = nil)
    @value = value
    @next = next_node_ref
  end
  attr_accessor :value, :next
end
