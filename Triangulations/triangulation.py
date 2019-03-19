import numpy
import pdb

class Triangulation:
    # Stores a triangulation of an n-gon as a list of diagonals
    # AND as an adjacency matrix of vertices

    def __init__(self, dimension):
        assert(dimension >= 3) #This is a polygon
        self.n = dimension
        #adjacency matrix of diagonals, initialized with 0 everywhere:
        self.adjacency = numpy.zeros([self.n, self.n])
        self.diagonals = [] #list of diagonals as tuples (low-to-high index)
        self.rotation = 0 #how far the indices are rotated (offset)

    def add_diagonal(self, x, y): #insert diagonal between x and y
        assert(x >= 0 and y >= 0 and x < self.n and y < self.n and x != y)
        (i, j) = self.raw_inds(x,y) #compensate for rotation
        assert(self.adjacency[i][j] == self.adjacency[j][i])
        if (self.adjacency[i][j] == 0):
            self.adjacency[i][j] = 1
            self.adjacency[j][i] = 1
            self.diagonals.append((min(i,j),max(i,j)))

    def raw_inds(self, x, y): #adjusts for rotation
        return ((x - self.rotation) % self.n, (y - self.rotation) % self.n)

    def rot_inds(self, i, j): #takes raw indices and gives rotated indices
        return ((i + self.rotation) % self.n, (j + self.rotation) % self.n)

    def __contains__(self, t):
        (i, j) = self.raw_inds(t[0], t[1])
        assert(self.adjacency[i][j] == self.adjacency[j][i])
        return self.adjacency[i][j] == 1

    def rotate(self, k=1): #rotate the indices
        self.rotation = (self.rotation + k) % self.n

    def true_diagonals(self): #adjusted for rotation
        result = []
        for d in self.diagonals:
            (i, j) = ( (d[0]+self.rotation)%self.n,
                       (d[1]+self.rotation)%self.n )
            result.append( (min(i, j), max(i, j)) )
        return result

    def normalize_labels(self):
        self.diagonals = self.true_diagonals()
        #adjust the adjacency matrix so the rotation can be 0
        self.adjacency = numpy.roll(self.adjacency, -self.rotation, [0,1])
        self.rotation = 0

    def add_vertex(self):
        self.normalize_labels() #necessary to ensure the new vertex is at the end
        # add a row and column of zeroes on the ends
        self.adjacency = numpy.pad(self.adjacency, (0,1), 'constant', constant_values=(0))
        self.n += 1

    def __str__(self):
        return str(self.true_diagonals())

    def __repr__(self):
        return (self.adjacency, self.diagonals, self.rotation)
