/* Physics */

Ball b;
float gravity = 1;

void setup() {
  size(500,500);
  noStroke();
  smooth(3);
  ellipseMode(CENTER);
  b = new Ball(100, 100, 1, 2, 50, 2);
}

void draw(){
  background(100);
  b.display();
  b.move2();
  b.move();
}

class Ball {
  float pX;
  float pY;
  float vX;
  float vY;
  float size;
  float mass;
  float fX;
  float fY;
  
  Ball(float _pX, float _pY, float _fX, float _fY, float _size, float _mass) {
    pX = _pX;
    pY = _pY;
    fX = _fX;
    fY = _fY;
    size = _size;
    mass = mass;
  }
  void display() {
    fill(255);
    ellipse(pX, pY, size, size);
  }
  void move(){
    if (pX < 0 || pX > width) {
      vX = -vX;
    }
    else if (pY < 0 || pY > height) {
      vY = -vY;
    }
    //vY = vY + gravity;
    pX = pX + vX;
    pY = pY + vY;
  }
  void move2() {
    fY = gravity * mass + vY*mass;
    fX = vX*mass;
  }
}
