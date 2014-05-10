require 'forwardable'

class Node
  extend Forwardable

  attr_accessor :board, :moves, :previous_node
  def_delegators :board, :is_goal?, :neighbors

  def initialize(board, moves, previous_node)
    @board = board
    @moves = moves
    @previous_node = previous_node
  end

  def manhattan
    board.manhattan + moves
  end

  def hamming
    board.hamming + moves
  end

  def previous_board
    previous_node ? previous_node.board : nil
  end
end

class MinimumPriorityQueue
  attr_accessor :queue, :size, :comparator
  def initialize(comparator = nil)
    @queue = [nil]
    @comparator = comparator
  end

  def size
    queue.compact.size
  end

  def is_empty?
    size == 0
  end

  def insert(item)
    queue.push(item)
    swim(size)
  end

  def delete_minimum
    exchange(1, size)
    minimum = queue.pop
    sink(1)
    minimum
  end

  private

  def swim(index)
    while index > 1 && greater(index / 2, index)
      exchange(index, index/2)
      index = index/2
    end
  end

  def sink(index)
    while 2 * index < size
      j = 2 * index
      j += 1 if j < size && greater(j, j + 1)
      break if !greater(index, j)
      exchange(index, j)
      index = j
    end
  end

  def greater(i, j)
    if comparator.nil?
      queue[i] > queue[j]
    else
      queue[i].send(comparator.to_sym) > queue[j].send(comparator.to_sym)
    end
  end

  def exchange(i, j)
    queue[i], queue[j] = queue[j], queue[i]
  end
end