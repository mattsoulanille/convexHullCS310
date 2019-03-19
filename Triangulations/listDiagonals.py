from generators import *

t = Triangulation(5);
t.add_diagonal(1,3)
t.add_diagonal(1,4)
#print(t)
for x in rots_we_want(t, 1, 3):
    print(x)
