require 'minitest/autorun'
require 'shoulda'
require 'minimum_priority_queue'

class MinimumPriorityQueueTest < MiniTest::Test
  context "#is_empty?" do
    context "given no elements" do
      should "return true" do
        mpq = MinimumPriorityQueue.new
        assert_equal true, mpq.is_empty?
      end
    end

    context "given some elements" do
      should "return false" do
        mpq = MinimumPriorityQueue.new
        mpq.insert(1)
        assert_equal false, mpq.is_empty?
      end
    end
  end

  context "#size" do
    should "return the size of the queue" do
      mpq = MinimumPriorityQueue.new
      mpq.insert(1)
      assert_equal 1, mpq.size
    end
  end

  context "#insert" do
    should "insert an item into the priority queue" do
      mpq = MinimumPriorityQueue.new
      mpq.insert(1)
      assert_equal [nil, 1], mpq.queue
    end

    should "maintain priority order" do
      mpq = MinimumPriorityQueue.new
      mpq.insert(10)
      assert_equal [nil, 10], mpq.queue

      mpq.insert(5)
      assert_equal [nil, 5, 10], mpq.queue

      mpq.insert(1)
      assert_equal [nil, 1, 10, 5], mpq.queue

      mpq.insert(4)
      assert_equal [nil, 1, 4, 5, 10], mpq.queue
    end
  end

  context "#delete_minimum" do
    should "delete the minimum node" do
      mpq = MinimumPriorityQueue.new
      mpq.insert(10)
      mpq.insert(5)
      assert_equal 5, mpq.delete_minimum
    end

    should "maintain priority order" do
      nums = [10,5,1,4]
      mpq = MinimumPriorityQueue.new
      nums.each { |num| mpq.insert(num) }
      nums.sort.each do |num|
        assert_equal num, mpq.delete_minimum
      end
    end
  end
end