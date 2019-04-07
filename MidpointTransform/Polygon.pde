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
     for (Point p : points) {
       double factor = 10;
       double dx = (Math.random() - 0.5) * factor;
       double dy = (Math.random() - 0.5) * factor;
       Point newPoint = new Point(p.x + dx, p.y + dy);
       newPoints.add(newPoint);
     }
     points = newPoints;
  }
}
