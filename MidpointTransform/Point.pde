// Daniel Fesbach, Matthew Soulanille

class Point {
  private float scale;
  public double x;
  public double y;  
  public Point(double x, double y) {
    scale = 10; // Statics are not allowed for whatever reason
    this.x = x;
    this.y = y;
  }
  void draw() {
    ellipse((float) x, (float) y, scale, scale);
  }
  
  public double cross(Point other){ //cross product of self and other
    // positive is out of the screen, negative is into the screen
    return x*other.y - y*other.x;   
  }
  
  public double relativeCross(Point p1, Point p2){ 
    //p1 cross p2, with the current point as the origin
    Point relative1 = new Point(p1.x-x, p1.y-y);
    Point relative2 = new Point(p2.x-x, p2.y-y);
    return relative1.cross(relative2);
  }
  
  public int sideOfLine(Point p1, Point p2){
    double rc = relativeCross(p1,p2);
    if (rc > 0){ // if the point is to the left of the line
      return -1;
    }
    else if (rc == 0){ //the point is on the line
      return 0; 
    }
    else {
      return 1; // the point is to the right of the line
    }
  }
  
  public Boolean leftOrColinearTo(Point p1, Point p2){ 
    //is this point to the left of, or colinear to, the line defined from p1 to p2?
    Point relative1 = new Point(p1.x-x, p1.y-y);
    Point relative2 = new Point(p2.x-x, p2.y-y);
    return relative1.cross(relative2) >= 0;
  }
  
  public Boolean equals(Point other){
    return (other.x == x) && (other.y == y);
  }
  
  public double distanceSquared(Point other){
     return Math.pow(other.x-x, 2) + Math.pow(other.y-y, 2);
  }
  
  public double distance(Point other) {
   return Math.sqrt(distanceSquared(other)); 
  }
  
  public void add(Point other) {
    x += other.x;
    y += other.y;
  }
  
  public void subtract(Point other) {
    x -= other.x;
    y -= other.y;
  }
  
  public void scale(double val) {
   x *= val;
   y *= val;
  }
  
}
