public class RandomPointset {
  
  public ArrayList<Point> points;

  public RandomPointset(int count, double radius, double offset, Point origin) {
    points = new ArrayList<Point>();
    for (int i = 0; i < count; i++) {
      Point randomPoint = sample(origin, radius, offset);
      points.add(randomPoint);
    }
  }
  public RandomPointset(int count, double radius, double offset) {
    this(count, radius, offset, new Point(WIDTH / 2, HEIGHT / 2));
  }
  public RandomPointset(int count, double radius) {
    this(count, radius, radius / 5);   
  }
  public RandomPointset(int count) {
    this(count, Math.min(WIDTH, HEIGHT) * 1.8/4.0);
  }
  public RandomPointset() {
   this(100); 
  }
  
  private Point sample(Point origin, double radius, double offset) {
     double angle = Math.random() * 2 * Math.PI;
     double distanceToOrigin = (Math.random() - 0.5) * offset + radius;
     return new Point(Math.cos(angle) * distanceToOrigin + origin.x,
                      Math.sin(angle) * distanceToOrigin + origin.y);
    
  }
  
  
}
