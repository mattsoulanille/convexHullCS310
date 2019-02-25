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
    Point previous = points.get(points.size() - 1);
    for (Point p: points) {
      p.draw(); // Draw the point
      line((float) previous.x, (float) previous.y,
           (float) p.x, (float) p.y);
      previous = p;      
    }
  }
}
