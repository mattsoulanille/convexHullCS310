int WINDOW_WIDTH = 800;
int WINDOW_HEIGHT = 600;



PointList pointList = new PointList();

Pseudogon p;

void setup() {
  pointList.addPoint(new Point(400, 200)); // A triangle with a colinear point
  pointList.addPoint(new Point(400, 400));
  pointList.addPoint(new Point(600, 300));
  pointList.addPoint(new Point(600, 300));
  p = new Pseudogon(pointList.points);
  
  
  background(255, 255, 255);
  fill(0, 0, 0);
  size(800, 600); // WIDTH x HEIGHT. Processing does not allow consts D:
  pixelDensity(2); // Retina screen
}

void draw() {
  p.midpointTransform();
  clear();
  background(255, 255, 255);
  p.draw();
}
  
  
