require 'minitest/autorun'
require 'shoulda'
require 'board'

class BoardTest < MiniTest::Test
  context "#dimension" do
    should "return the dimension of the board" do
      board = Board.new([[1,2,3],[4,5,6],[7,8,0]])
      assert_equal 3, board.dimension
    end
  end

  context "#is_goal?" do
    context "given the board is a solution" do
      should "return true" do
        board = Board.new([[1,2,3],[4,5,6],[7,8,0]])
        assert_equal true, board.is_goal?
      end
    end

    context "given the board is not a solution" do
      should "return false" do
        board = Board.new([[2,1,3],[4,5,6],[7,8,0]])
        assert_equal false, board.is_goal?
      end
    end
  end

  context "#hamming" do
    should "return the hamming score" do
      board = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal 5, board.hamming
    end
  end

  context "#manhattan" do
    should "return the manhattan score" do
      board = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal 10, board.manhattan
    end
  end

  context "#equals?" do
    should "return true if the blocks are equal" do
      board_one = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      board_two = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal true, board_one.equals?(board_two)
    end

    should "return false if the blocks are not equal" do
      board_one = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      board_two = Board.new([[1,8,3],[4,0,2],[7,6,5]])
      assert_equal false, board_one.equals?(board_two)
    end

    should "return false if the input board is nil" do
      board_one = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal false, board_one.equals?(nil)
    end
  end

  context "#neighbors" do
    should "return an array of neighbors from the current board" do
      board = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal 4, board.neighbors.size
      assert_equal true, board.neighbors.map(&:blocks).include?([[8,0,3],[4,1,2],[7,6,5]])
      assert_equal true, board.neighbors.map(&:blocks).include?([[8,1,3],[0,4,2],[7,6,5]])
      assert_equal true, board.neighbors.map(&:blocks).include?([[8,1,3],[4,2,0],[7,6,5]])
      assert_equal true, board.neighbors.map(&:blocks).include?([[8,1,3],[4,6,2],[7,0,5]])
    end
  end

  context "#twin" do
    should "return a board with two adjacent numbers switched" do
      board = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal [[1,8,3],[4,0,2],[7,6,5]], board.twin.blocks
    end

    context "given zero is in the first row" do
      should "return a board with two adjacent numbers switched" do
        board = Board.new([[8,0,3],[4,1,2],[7,6,5]])
        assert_equal [[8,0,3],[1,4,2],[7,6,5]], board.twin.blocks
      end
    end
  end

  context "#to_s" do
    should "return the matrix as a string" do
      board = Board.new([[8,1,3],[4,0,2],[7,6,5]])
      assert_equal "8 1 3\n4   2\n7 6 5", board.to_s
    end
  end
end