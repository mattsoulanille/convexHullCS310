int WINDOW_WIDTH = 800;
int WINDOW_HEIGHT = 600;



PointList pointList = new PointList();

Pseudogon p;
boolean play = false;
boolean conserve = false;
boolean step = false;
int stepsPerFrame = 1;

void setup() {
  pointList.addPoint(new Point(400, 200)); // A triangle with a colinear point
  pointList.addPoint(new Point(400, 400));
  pointList.addPoint(new Point(600, 300));
  pointList.addPoint(new Point(600, 200));
  
  p = new Pseudogon(pointList.points);
  
  
  background(255, 255, 255);
  fill(0, 0, 0);
  size(800, 600); // WIDTH x HEIGHT. Processing does not allow consts D:
  pixelDensity(2); // Retina screen
}

void mouseReleased() {
  p.addPoint(new Point(mouseX, mouseY));
}
void mouseDragged() {
  p.addPoint(new Point(mouseX, mouseY));
}

void keyPressed() {
  if (key == ' ') {
     // If we get a spacebar
     play = ! play;
  }
  if (key == 'r') {
     p.points.clear();
  }
  if (key == 'c') {
     conserve = ! conserve; 
  }
  if (key == 's') {
     step = true; 
  }
  if (keyCode == 37) {
    // Left Arrow
    stepsPerFrame = stepsPerFrame >> 1;
    if (stepsPerFrame < 1) {
     stepsPerFrame = 1; 
    }
  }
  if (keyCode == 39) {
    // Right Arrow
    stepsPerFrame = stepsPerFrame << 1;
  }
}

void draw() {
  drawModes();
  
  clear();
  background(255, 255, 255);
  p.draw();
  
  if (play || step) {
    for (int i = 0; i < stepsPerFrame; i++) {
      if (conserve) {
        p.midpointTransformConservative();
      }
      else {
        p.midpointTransform();
      }
    }
    step = false;
  }
}
  
  
void drawModes() {
  
  
}
  
