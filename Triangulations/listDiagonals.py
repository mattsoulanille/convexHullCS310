from triangulation import *

t = Triangulation(4);
t.add_diagonal(1,3)
#print(t)
for x in rots_we_want(t, 1, 3):
    print(x)
