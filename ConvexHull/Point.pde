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
}
