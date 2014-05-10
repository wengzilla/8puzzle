class Board
  attr_accessor :blocks, :manhattan_score, :hamming_score

  def initialize(blocks)
    @blocks = blocks
    @manhattan_score = nil
    @hamming_score = nil
  end

  def dimension
    blocks.size
  end

  def hamming
    return hamming_score if hamming_score
    score = 0
    blocks.each_with_index do |row, y|
      row.each_with_index do |num, x|
        next if num.zero?
        score += 1 if dimension * y + x + 1 != num
      end
    end
    self.hamming_score = score
  end

  def manhattan
    return manhattan_score if manhattan_score
    score = 0
    blocks.each_with_index do |row, y|
      row.each_with_index do |num, x|
        next if num.zero?
        expected_row = (num - 1) / 3
        expected_col = (num - 1) % 3
        score += (expected_col - x).abs + (expected_row - y).abs
      end
    end
    self.manhattan_score = score
  end

  def is_goal?
    equals?(goal_board)
  end

  def twin
    blocks.each_with_index do |row, row_index|
      next if row.include?(0)
      return swap(row_index, 0, row_index, 1)
    end
  end

  def equals?(board)
    board.nil? ? false : blocks == board.blocks
  end

  def neighbors
    y,x = zero_position
    Array.new.tap do |neighbors|
      neighbors.push(swap(y-1,x,y,x)) if y-1 >= 0
      neighbors.push(swap(y+1,x,y,x)) if y+1 < dimension
      neighbors.push(swap(y,x-1,y,x)) if x-1 >= 0
      neighbors.push(swap(y,x+1,y,x)) if x+1 < dimension
    end
  end

  def to_s
    blocks.map do |row|
      row.join(" ").gsub(/(\s)0/){ "#{$1} " }
    end.join("\n")
  end

  private

  def swap(y1, x1, y2, x2)
    new_blocks = Marshal.load(Marshal.dump(blocks)).tap do |array_copy|
      array_copy[y2][x2], array_copy[y1][x1] = array_copy[y1][x1], array_copy[y2][x2]
    end
    Board.new(new_blocks)
  end

  def zero_position
    blocks.each_with_index do |row, y|
      row.each_with_index do |num, x|
        return [y, x] if num.zero?
      end
    end
  end

  def goal_board
    @goal_board ||= begin
      array = (1...dimension ** 2).to_a
      array.push(0)
      sorted_blocks = array.each_slice(dimension).map { |slice| slice }
      Board.new(sorted_blocks)
    end
  end
end