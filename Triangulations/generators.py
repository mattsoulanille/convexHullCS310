from triangulation import *
from copy import deepcopy

#### Rotating and pruning an existing triangulation ####
def all_rotations(tri:Triangulation, x:int, y:int):
    r = deepcopy(tri) #copy to be rotated
    n = tri.n
    for i in range(n):
        yield (deepcopy(r), ((x+i)%n, (y+i)%n))
        r.rotate()

def integrated_filter(rotations, to_exclude=[]):
    (t, d) = next(rotations) #d is the canonical diagonal
    keep = True
    i = 0
    while (keep and i<len(to_exclude)):
        keep &= (to_exclude[i] not in t)
        i += 1
    if keep:
        yield t
    yield from integrated_filter(rotations, to_exclude+[d])

def rots_we_want(tri:Triangulation, x:int, y:int):
    yield from integrated_filter(all_rotations(tri, x, y))


###### Recursively generating triangulations ######

# Takes a generator of triangulations polygons of size n
# Generates triangulations of polygons of size n+1
def gen_bigger_triangulations(g):
    for t in g:
        t.add_vertex() # the new vertex will be at the end
        (x, y) = (0, t.n-2)
        t.add_diagonal(x, y) #cut this off as an ear
        yield from rots_we_want(t, x, y)

# Generate all triangulations of a convex n-gon
def gen_triangulations(n):
    assert (n>=3)
    if n==3:
        yield Triangulation(3)
    else:
        yield from gen_bigger_triangulations(gen_triangulations(n-1))
