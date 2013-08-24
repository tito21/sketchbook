
color cr;
float size;
void setup() {
  size(500, 500);
  noStroke();
  ellipseMode(CENTER);
}
void draw() {
  if (mousePressed) {
    cr = color(random(255), random(255),random(255)); 
    size = random(50);
    Point point = new Point(mouseX, mouseY, cr, size);
    point.disp();
  } 
}

class Point {
  float posX;
  float posY;
  color c;
  float size;
  
  Point(float posX_, float posY_, color c_, float size_) {
    posX = posX_;
    posY = posY_;
    c    = c_;
    size = size_;
  }
  void disp(){
    fill(c);
    ellipse(posX, posY, size, size);
  }
}
