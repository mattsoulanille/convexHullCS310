class Polygon {
  private ArrayList<Point> points;
  public Polygon() {
    points = new ArrayList<Point>(); 
  }
  public Polygon(ArrayList<Point> points) {
    this.points = points;  
  }
  public void addPoint(Point p) {
    points.add(p); 
  }
  public void draw() {
    Point previous = points.get(points.size() - 1);
    for (Point p: points) {
      p.draw(); // Draw the point
      line((float) previous.x, (float) previous.y,
           (float) p.x, (float) p.y);
      previous = p;      
    }
  }
}
