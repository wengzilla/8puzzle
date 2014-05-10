This is a programming assignment from the Coursera Princeton Algorithm's course: http://coursera.cs.princeton.edu/algs4/assignments/8puzzle.html

##The problem

The 8-puzzle problem is a puzzle invented and popularized by Noyes Palmer Chapman in the 1870s. It is played on a 3-by-3 grid with 8 square blocks labeled 1 through 8 and a blank square. Your goal is to rearrange the blocks so that they are in order, using as few moves as possible. You are permitted to slide blocks horizontally or vertically into the blank square. The following shows a sequence of legal moves from an initial board (left) to the goal board (right).

##Solution

This solution uses the A* search algorithm backed by a minimum priority queue. Two priority functions have been implemented:

- Hamming priority function. The number of blocks in the wrong position, plus the number of moves made so far to get to the search node. Intutively, a search node with a small number of blocks in the wrong position is close to the goal, and we prefer a search node that have been reached using a small number of moves.

- Manhattan priority function. The sum of the Manhattan distances (sum of the vertical and horizontal distance) from the blocks to their goal positions, plus the number of moves made so far to get to the search node.

Please refer to the assignment documentation for examples on how to calculate each of the priorities.