class Pseudogon {
  
  // For storing and drawing "polygons"
  // Stores a list of points
  // Draws lines between them as if it's a polygon
  // No guarantees that it's actually a polygon
  
  private ArrayList<Point> points;
  public Pseudogon() { // Constructs an empty Pseudogon
    points = new ArrayList<Point>(); 
  }
  public Pseudogon(ArrayList<Point> points) { // Constructs a Pseudogon from a given list of points
    // precondition: this list is a valid Pseudogon
    this.points = points;  
  }
  public void addPoint(Point p) { // Appends a point
    points.add(p); 
  }
  public void draw() { // Draws the Pseudogon
    Point previous = points.get(points.size() - 1);
    for (Point p: points) {
      p.draw(); // Draw the point
      line((float) previous.x, (float) previous.y,
           (float) p.x, (float) p.y);
      previous = p;      
    }
  }
}
