// Daniel Fesbach, Matthew Soulanille

class Pseudogon extends PointList{
  
  // For storing and drawing "polygons"
  // Stores a list of points
  // Draws lines between them as if it's a polygon
  // No guarantees that it's actually a polygon
  
  public Pseudogon() { // Constructs an empty Pseudogon
    super(); 
  }
  public Pseudogon(List<Point> newpoints) { // Constructs a Pseudogon from a given list of points
    super(newpoints); 
  }
  public void draw() { // Draws the Pseudogon
    if (points.size() == 0) {
       return; 
    }
    stroke(204, 102, 0);
    fill(204, 102, 0);
    Point previous = points.get(points.size() - 1);
    for (Point p: points) {
      p.draw(); // Draw the point
      line((float) previous.x, (float) previous.y,
           (float) p.x, (float) p.y);
      previous = p;      
    }
  }
  
  public void midpointTransform() {
     // Apply the midpoint transform to the points in the pseudogon. 
     // Right now, it just randomly nudges them by a bit.
     
     List<Point> newPoints = new ArrayList<Point>();
     int size = points.size();
     for (int index = 0; index < size; index ++) {
       Point current = points.get(index);
       Point next = points.get((index + 1) % size);
       Point midpoint = new Point((current.x + next.x) / 2.0,
                                  (current.y + next.y) / 2.0);
       
       newPoints.add(midpoint);
     }
     points = newPoints;
  }
  
  public void midpointTransformConservative() {
     double beforePerimeter = getPerimeter();
     midpointTransform();
     double afterPerimeter = getPerimeter();
     double scaleBy = beforePerimeter / afterPerimeter;
     scaleTo(scaleBy);
  }
  
  public Point getCenter() {
    Point sum = new Point(0, 0);
    if (points.size() == 0) {
      return sum;  
    }
    
    for (Point p : points) {
      sum.x += p.x;
      sum.y += p.y;
    }//divide by num of pts, beware 0-gon
    
    sum.x /= points.size();
    sum.y /= points.size();
    return sum;
  }
  
  public double getPerimeter() {
    if (points.size() == 0) {
     return 0; 
    }
    
    double perimeter = 0;
    
    int size = points.size();
     for (int index = 0; index < size; index ++) {
       Point current = points.get(index);
       Point next = points.get((index + 1) % size);
       perimeter += current.distance(next);
     }
     
    return perimeter;
  }
  
  public void scaleTo(double proportion) {
    Point center = getCenter();
    for (Point p: points) {
       p.subtract(center);
       p.scale(proportion);
       p.add(center);
    }
  }
}
