from triangulation import *

t = Triangulation(5);
t.add_diagonal(1,3)
t.add_diagonal(0,3)
#print(t)
for x in integrated_filter(all_rotations(t, 1, 3)):
    print(x)
