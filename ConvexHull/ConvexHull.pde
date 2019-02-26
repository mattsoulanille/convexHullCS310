// Daniel Fesbach, Matthew Soulanille

import java.util.Stack;

int WINDOW_WIDTH = 800;
int WINDOW_HEIGHT = 600;

PointList PointList = new RandomPointListCircle(100);

int startTime = millis();
//Pseudogon p = (Pseudogon)points;
//Pseudogon p = NaiveConvexHull(PointList);
Pseudogon p = GrahamScan(PointList);
int endTime = millis();


void setup() {
  size(800, 600); // WIDTH x HEIGHT. Processing does not allow consts D:
  pixelDensity(2); // Retina screen
  print(endTime-startTime);
  noLoop();
}

void draw() {
  PointList.draw();
  p.draw();
}

Pseudogon GrahamScan(PointList points){
  /* Convex hull via the Graham Scan algorithm */
  
  /* This isn't a polygon, but we need to rule this out 
     so we can later index into the first 3 positions */
  if(points.count() < 3){
    return (Pseudogon)points; 
  }
  
  // Find a lowest point
  Point low = points.lowestPoint();
  // Angularly sort the other points counterclockwise to low
  points.sortWithRemovalCCW(low);
  
  // Initialize polygon to the first 2 points
  PikaStack<Point> stack = new PikaStack<Point>();
  stack.push(low);
  stack.push(points.getPoint(1));
  
  //for (int i=2; i<points.count(); i++){
  int i=2;
  while (i < points.count()){
    Point next = points.getPoint(i);
    Point here = stack.peek(0);
    Point prev = stack.peek(1);
    
    if (here.leftOrColinearTo(prev, next)){
      stack.pop();
    }
    else {
      i++;
      stack.push(next);
    }
  }
  
  return new Pseudogon(stack.data);
  
}

Pseudogon NaiveConvexHull(PointList pointset){
  /* Checks all point pairs for whether all other points 
     are on the same side of the line */
  List<Point> points = pointset.points;
  HashMap<Point, Point> segments = new HashMap();
  
  // For each distinct, directed pairs of points (p1, p2)
  for(Point p1: points){
    for(Point p2: points){
      if(p1.equals(p2)){
        continue;
      }
      // Consider the line defined from p1 to p2
      Boolean allLeft = true;
      // Loop over all the other points:
      for(Point p3: points){
        if(p3.equals(p1) || p3.equals(p2)){
          continue;
        }
        allLeft = allLeft && p3.leftOrColinearTo(p1, p2);
        if(!allLeft){
          break; 
        }
      }
      if(allLeft){ 
        // If all points are to the left of (or colinear to) the line,
        //  this segment will be part of the convex hull.
        // Insert into the hash table with the source as the key
        //  and the target as the value.
        segments.put(p1, p2);
      }
    }
  }
  
  /* Now we have a hash table of all the segments 
      which will be in the convex hull.  */
  Point start = segments.keySet().iterator().next(); //some point
  Pseudogon poly = new Pseudogon(); //result to output
  poly.addPoint(start);
  Point next = segments.get(start);
  while (!next.equals(start)){
    poly.addPoint(next);
    next = segments.get(next); //the point after next
  }
  return poly;  
}
