
Polygon p = new Polygon();
void setup() {
  size(800, 600);
  pixelDensity(2); // Retina screen
  p.addPoint(new Point(80, 30));
  p.addPoint(new Point(70, 160));
  p.addPoint(new Point(200, 370));
  p.addPoint(new Point(400, 500));
}



void draw() {
  p.draw();
}
