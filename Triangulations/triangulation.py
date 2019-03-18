import numpy
from copy import copy
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

    def raw_inds(self, i, j): #adjusts for rotation
        return ((i - self.rotation) % self.n, (j - self.rotation) % self.n)

    def __contains__(self, t):
        (i, j) = self.raw_inds(t[0], t[1])
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

    #generates all the rotations of this triangulation,
    #   filtering out ones (other than 0) which also have edge (i, j)
    def filtered_rotations(self, x, y):
        assert((x,y) in self) #otherwise this doesn't make any sense
        rot = copy(self) #copy to be rotated
        yield copy(rot)
        rot.rotate()
        for i in range(1, self.n):
            if (x,y) not in rot:
                pdb.set_trace()
                yield copy(rot)
            rot.rotate()
        assert (rot.rotation == self.rotation) # sanity check


    def __str__(self):
        print(self.true_diagonals())
