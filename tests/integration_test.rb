require 'minitest/autorun'
require 'shoulda'
require 'solver'

class IntegrationTest < MiniTest::Test
  context "solvable puzzle" do
    should "return a solution that contains 1 moves" do
      s = Solver.new(Board.new([[1,2,3],[4,5,6],[7,8,0]]), :manhattan)
      s.solve
      assert_equal [[[1,2,3],[4,5,6],[7,8,0]]], s.solution
    end

    should "return a solution that contains 2 moves" do
      s = Solver.new(Board.new([[1,2,0],[4,5,3],[7,8,6]]), :manhattan)
      s.solve
      assert_equal [[[1, 2, 0], [4, 5, 3], [7, 8, 6]], [[1, 2, 3], [4, 5, 0], [7, 8, 6]], [[1, 2, 3], [4, 5, 6], [7, 8, 0]]], s.solution
    end

    should "return a solution that contains 4 moves" do
      s = Solver.new(Board.new([[0,1,3],[4,2,5],[7,8,6]]), :manhattan)
      s.solve
      assert_equal [[[0, 1, 3], [4, 2, 5], [7, 8, 6]], [[1, 0, 3], [4, 2, 5], [7, 8, 6]], [[1, 2, 3], [4, 0, 5], [7, 8, 6]], [[1, 2, 3], [4, 5, 0], [7, 8, 6]], [[1, 2, 3], [4, 5, 6], [7, 8, 0]]], s.solution
    end
  end

  context "unsolvable puzzle" do
    should "return infeasible" do
      s = Solver.new(Board.new([[1,2,3],[4,6,5],[7,8,0]]), :manhattan)
      s.solve
      assert_equal "infeasible", s.solution
    end
  end
end