int WIDTH = 800;
int HEIGHT = 600;

RandomPointSetRectangle pointset = new RandomPointSetRectangle();
Pseudogon p = new Pseudogon(pointset.points);

void setup() {
  size(800, 600); // WIDTH x HEIGHT. Processing does not allow consts D:
  pixelDensity(2); // Retina screen
  
}


void draw() {
  p.draw();
}
