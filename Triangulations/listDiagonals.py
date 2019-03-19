from generators import *


def gen_quad():
    t = Triangulation(4);
    t.add_diagonal(0,2)
    yield deepcopy(t)
    t.rotate()
    yield deepcopy(t)


count=0
for x in gen_triangulations(7):
    count += 1
    #print(x)

print(count)
