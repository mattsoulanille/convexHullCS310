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

    def raw_inds(self, x, y): #adjusts for rotation
        return ((x - self.rotation) % self.n, (y - self.rotation) % self.n)

    def rot_inds(self, i, j): #takes raw indices and gives rotated indices
        return ((i + self.rotation) % self.n, (j + self.rotation) % self.n)

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

    def __str__(self):
        return str(self.true_diagonals())

#generates all the rotations of this triangulation
def all_rotations(tri:Triangulation):
    r = copy(tri) #copy to be rotated
    for i in range(0, tri.n):
        yield copy(r)
        r.rotate()
    assert (r.rotation == tri.rotation) # sanity check

#removes generated triangulations with edge (x,y)
def filter_out(g, x:int, y:int):
    for t in g:
        if not (x,y) in t:
            yield t

def filter_out_all(g, to_exclude):
    filtered = g
    for diag in to_exclude:
        filtered = filter_out(filtered, diag[0], diag[1])
    yield from filtered

def filter_except_first(g, x:int, y:int):
    yield next(g)
    yield from filter_out(g, x, y)

def rotations_of_diag(x:int, y:int, n:int):
    for i in range(n):
        yield ((x+i)%n, (y+i)%n)

def cascade_filter(rotations, diagonals):
    filtered = rotations
    for diag in diagonals:
        yield next(filtered)
        filtered = filter_out(filtered, diag[0], diag[1])

def rots_we_want(tri:Triangulation, x:int, y:int):
    yield from cascade_filter(all_rotations(tri), rotations_of_diag(x, y, tri.n))
