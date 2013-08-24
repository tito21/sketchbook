B b1, b2;


void setup() {
  size(350, 350);
  b1 = new B(width/2, height/2);
  b2 = new B(width/3, height/5);
  frameRate(12);
}

void draw() {
  background(100);

  b1.dis();
  b2.dis();
  b1.move();
  b2.move();
}

class B {
  float x;
  float y;
  float xt;
  float yt;

  B(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void dis() {
    ellipse(x, y, 30, 30);
  }

  void move() {
    x += random(-5, 5);
    y += random(-5, 5);
  }
}



