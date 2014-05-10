require 'board'
require 'minimum_priority_queue'

class Solver
  attr_accessor :initial_board, :queue, :twin_queue, :current_node, :current_twin_node

  def initialize(initial_board, comparator)
    @queue = MinimumPriorityQueue.new(comparator)
    @twin_queue = MinimumPriorityQueue.new(comparator)
    queue.insert(Node.new(initial_board, 0, nil))
    twin_queue.insert(Node.new(initial_board.twin, 0, nil))
  end

  def is_solvable?
    current_node.is_goal?
  end

  def moves
    is_solvable? ? solution.length - 1 : -1
  end

  def solution
    if is_solvable?
      path = []
      node = current_node
      begin
        path.unshift(node.board.blocks)
        node = node.previous_node
      end while node
      path
    else
      "infeasible"
    end
  end

  def solve
    begin
      self.current_node = queue.delete_minimum
      self.current_twin_node = twin_queue.delete_minimum

      current_node.neighbors.each do |n|
        unless n.equals?(current_node.previous_board)
          queue.insert(Node.new(n, current_node.moves + 1, current_node))
        end
      end

      current_twin_node.neighbors.each do |n|
        unless n.equals?(current_twin_node.previous_board)
          twin_queue.insert(Node.new(n,current_twin_node.moves + 1, current_twin_node))
        end
      end
    end until (current_node.is_goal? || current_twin_node.is_goal?)
  end
end