require 'solver'

contents = File.read(ARGV[0]).strip
blocks = contents.split("\n")[1..-1].map{ |row| row.split(" ").map(&:to_i) }
s = Solver.new(Board.new(blocks), :manhattan)
s.solve
puts s.solution