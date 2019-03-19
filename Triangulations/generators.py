def all_rotations(tri:Triangulation, x:int, y:int):
    r = copy(tri) #copy to be rotated
    n = tri.n
    for i in range(n):
        yield (copy(r), ((x+i)%n, (y+i)%n))
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
