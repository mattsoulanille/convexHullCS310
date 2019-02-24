public class RandomPointSetRectangle {
  // Samples points from within a rectangle
  public ArrayList<Point> points;

  public RandomPointSetRectangle(int count, double w, double h, Point topLeft) { 
    // Constructor: fills with randomly-sampled points
    // count: number of points
    // w: width of rectangle
    // h: height of rectangle
    // topLeft: top left point of rectangle
    points = new ArrayList<Point>();
    for (int i = 0; i < count; i++) {
      Point randomPoint = sample(topLeft, w, h);
      points.add(randomPoint);
    }
  }
  
  public RandomPointSetRectangle(int count, double w, double h) { 
    // Constructor with default top left point
    this(count, w, h, new Point(width / 4, height / 4)); //width and height are of the screen, w and h are of the rectangle
  }
  
  public RandomPointSetRectangle(int count) { 
    // Constructor with default rectangle size
    this(count, width/2, height/2);
  }
  
  public RandomPointSetRectangle() { 
    // Constructor with 100 points
    this(100);
  }
  
  private Point sample(Point topLeft, double w, double h) {
     // Returns a point randomly sampled within the rectangle: helper for constructor
     double x = Math.random() * w + topLeft.x;
     double y = Math.random() * h + topLeft.y;
     return new Point(x, y); 
  }
}


public class RandomPointSetCircle {
  // Samples points from NEAR the perimeter of a circle
  
  public ArrayList<Point> points;

  public RandomPointSetCircle(int count, double radius, double offset, Point origin) { 
    // Constructor: fills with randomly-sampled points
    points = new ArrayList<Point>();
    for (int i = 0; i < count; i++) {
      Point randomPoint = sample(origin, radius, offset);
      points.add(randomPoint);
    }
  }
  public RandomPointSetCircle(int count, double radius, double offset) {
    // Constructor which automatically uses origin as center of screen
    this(count, radius, offset, new Point(width / 2, height / 2));
  }
  public RandomPointSetCircle(int count, double radius) {
    // Constructor which automatically uses origin as center of screen
    // and caps the offset
    this(count, radius, radius / 5);   
  }
  public RandomPointSetCircle(int count) {
    // Constructor which also automatically sets the radius
    this(count, Math.min(width, height) * 1.8/4.0);
  }
  public RandomPointSetCircle() {
    // 100 points
   this(100); 
  }
  
  private Point sample(Point origin, double radius, double offset) {
     // Returns a point randomly sampled near the circle perimeter: helper for constructor
     double angle = Math.random() * 2 * Math.PI;
     double distanceToOrigin = (Math.random() - 0.5) * offset + radius;
     return new Point(Math.cos(angle) * distanceToOrigin + origin.x,
                      Math.sin(angle) * distanceToOrigin + origin.y);
    
  }  
}
