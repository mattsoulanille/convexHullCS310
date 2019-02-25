import java.util.Collections;
import java.util.List;
import java.util.Iterator;

public class PointList {
 
  public List<Point> points;
  
  public PointList(){
    points = new ArrayList<Point>();
  }
  
  public PointList(List<Point> newpoints){
    points = newpoints;
  }
  
  public void addPoint(Point p) { // Appends a point
    points.add(p); 
  }
  
  public Point lowestPoint(){ // Finds a lowest point
    assert(points.size() > 0);
    Point low = points.get(0);
    for(Point p: points){
      if (p.y < low.y) { low = p; }; 
    }
    return low;
  }
  
  public void sortCCW(Point origin){
    ComparatorCCW ccw = new ComparatorCCW(origin);
    Collections.sort(points, ccw);
  }
  
  public void sortWithRemovalCCW(Point origin){ //sorts, then removes identical points
    sortCCW(origin);
    Iterator<Point> iter = points.iterator();
    Point prev = iter.next();
    while (iter.hasNext()){
       Point current = iter.next();
       if (prev.equals(current)){
         iter.remove();
       }
       else {
         prev = current; 
       }
    }
  }
  
  public int count(){
    return points.size(); 
  }
  
  public Point getPoint(int i){
    return points.get(i);
  }
  
  public void draw() { // Draws the PointList
    for (Point p: points) {
      p.draw(); // Draw the point
    }
  }
  
}

public class RandomPointListRectangle extends PointList {
  // Samples points from within a rectangle
  
  public RandomPointListRectangle(int count, double w, double h, Point topLeft) { 
    // Constructor: fills with randomly-sampled points
    // count: number of points
    // w: WINDOW_WIDTH of rectangle
    // h: WINDOW_HEIGHT of rectangle
    // topLeft: top left point of rectangle
    super();
    for (int i = 0; i < count; i++) {
      Point randomPoint = sample(topLeft, w, h);
      points.add(randomPoint);
    }
  }
  
  public RandomPointListRectangle(int count, double w, double h) { 
    // Constructor with default top left point
    this(count, w, h, new Point(WINDOW_WIDTH / 4, WINDOW_HEIGHT / 4)); //WINDOW_WIDTH and WINDOW_HEIGHT are of the screen, w and h are of the rectangle
  }
  
  public RandomPointListRectangle(int count) { 
    // Constructor with default rectangle size
    this(count, WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
  }
  
  public RandomPointListRectangle() { 
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


public class RandomPointListCircle extends PointList {
  // Samples points from NEAR the perimeter of a circle
  
    public RandomPointListCircle(int count, double radius, double offset, Point origin) { 
    // Constructor: fills with randomly-sampled points
    super();
    for (int i = 0; i < count; i++) {
      Point randomPoint = sample(origin, radius, offset);
      points.add(randomPoint);
    }
  }
  public RandomPointListCircle(int count, double radius, double offset) {
    // Constructor which automatically uses origin as center of screen
    this(count, radius, offset, new Point(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2));
  }
  public RandomPointListCircle(int count, double radius) {
    // Constructor which automatically uses origin as center of screen
    // and caps the offset
    this(count, radius, radius / 5);   
  }
  public RandomPointListCircle(int count) {
    // Constructor which also automatically sets the radius
    this(count, Math.min(WINDOW_WIDTH, WINDOW_HEIGHT) * 1.8/4.0);
  }
  public RandomPointListCircle() {
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
