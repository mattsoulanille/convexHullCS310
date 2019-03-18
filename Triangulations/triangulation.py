import numpy

class Triangulation:
    # Stores a triangulation of an n-gon as a list of diagonals
    # AND as an adjacency matrix of vertices

    def __init__(self, dimension):
        assert(dimension >= 3) #This is a polygon
        self.n = dimension
        #adjacency matrix of diagonals, initialized with 0 everywhere:
        self.adjacency = numpy.zeros([self.n, self.n])
        self.diagonals = [] #list of diagonals as tuples (low-to-high index)

    def add_diagonal(self, i, j):
        assert(i >= 0 and j >= 0 and i < self.n and j < self.n and i != j)
        assert(self.adjacency[i][j] == self.adjacency[j][i])
        if (self.adjacency[i][j] == 0):
            self.adjacency[i][j] = 1
            self.adjacency[j][i] = 1
            self.diagonals.append((min(i,j),max(i,j))

    def __contains__(self, i, j):
        return self.adjacency[i][j] == 1
