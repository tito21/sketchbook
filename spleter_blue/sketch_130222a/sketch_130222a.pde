/* Physics */

Ball b;
float gravity = 1;

void setup() {
  size(500,500);
  noStroke();
  smooth(3);
  ellipseMode(CENTER);
  b = new Ball(100, 100, 1, 100, 50);
}

void draw(){
  background(100);
  b.display();
  b.move();
}

class Ball {
  float pX;
  float pY;
  float vX;
  float vY;
  float size;
  
  Ball(float _pX, float _pY, float _vX, float _vY, float _size) {
    pX = _pX;
    pY = _pY;
    vX = _vX;
    vY = _vY;
    size = _size;
  }
  void display() {
    fill(255);
    ellipse(pX, pY, size, size);
  }
  void move(){
    if (pX < 0 || pX > width) {
      vX = -vX; 
    }
    if (pY < 0 || pY > height) {
      vY = -vY;
    }
    vY = vY + gravity;
    pX = pX + vX;
    pY = pY + vY;
  }
}
