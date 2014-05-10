require 'minitest/autorun'
require 'shoulda'
require 'solver'
require 'mocha/mini_test'

class SolverTest < MiniTest::Test
  context "#initialize" do
    should "initialize two priority queues" do
      MinimumPriorityQueue.expects(:new).times(2).returns(stub(:insert => true))
      Solver.new(Board.new([[0,1,3],[4,2,5],[7,8,6]]), :manhattan)
    end

    should "insert a node and its twin node into two queues" do
      #PENDING
    end
  end

  context "#is_solvable?" do
    setup do
      @s = Solver.new(Board.new([[0,1,3],[4,2,5],[7,8,6]]), :manhattan)
    end

    should "return false if the current_node's board is not the goal" do
      @s.stubs(:current_node).returns(stub(:is_goal? => false))
      assert_equal false, @s.is_solvable?
    end

    should "return true if the current_node's board is not the goal" do
      @s.stubs(:current_node).returns(stub(:is_goal? => true))
      assert_equal true, @s.is_solvable?
    end
  end

  context "#moves" do
    setup do
      @s = Solver.new(Board.new([[0,1,3],[4,2,5],[7,8,6]]), :manhattan)
    end

    should "return -1 if the puzzle is not solvable" do
      @s.stubs(:is_solvable?).returns(false)
      assert_equal -1, @s.moves
    end

    should "return the count of moves if the puzzle is solvable" do
      @s.stubs(:solution).returns(["start","move_1","move_2"])
      @s.stubs(:is_solvable?).returns(true)
      assert_equal 2, @s.moves
    end
  end

  context "#solution" do
    setup do
      @s = Solver.new(Board.new([[0,1,3],[4,2,5],[7,8,6]]), :manhattan)
    end

    should "return 'infeasible' if the puzzle is not solvable" do
      @s.stubs(:is_solvable?).returns(false)
      assert_equal "infeasible", @s.solution
    end

    should "return the path to the solution if the puzzle is solvable" do
      starting_node = Node.new(Board.new([1]),0,nil)
      second_node = Node.new(Board.new([2]),1,starting_node)
      @s.stubs(:is_solvable?).returns(true)
      @s.stubs(:current_node).returns(second_node)
      assert_equal [[1],[2]], @s.solution
    end
  end

  context "#solve" do
    #PENDING
  end
end