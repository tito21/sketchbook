import java.util.Random;
ArrayList branches;

Random generator;

//0587 Felipe<3
void setup() {
  size(500, 500);
  background(255);
  smooth(2);
  fill(0, 0, 150);
  generator = new Random();
  branches = new ArrayList();
  branches.add(new Branch(width/2, height/2, width/2, 0, color(0)));
}

void draw() {
  for (int i = 0; i < branches.size (); i++) {
    Branch s = (Branch) branches.get(i);
    s.disp();
    s.update();
    s.feel();
  }
}

void mouseClicked() {
  float x = random(width);
  float y = random(height);
  branches.add(new Branch(mouseX, mouseY, x, y, color(random(100))));
  ellipse(x, y, 5, 5);
}
// A class that for a random walker  w/ target(!)
//
// Alberto Di Biase
//

class Branch {

  PVector loc;
  PVector vel;
  PVector acl;
  PVector tLoc;
  PVector oldLoc;
  PVector dis;
  float l;
  float mag;
  color c;
  Boolean arive;

  Branch(float posX, float posY, float _tX, float _tY, color _c) {

    loc = new PVector(posX, posY);
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);
    dis = new PVector(0, 0);
    tLoc = new PVector(_tX, _tY);
    oldLoc = new PVector(loc.x, loc.y);
    c = _c;
    arive = false;
  }

  void disp() {
    if (arive) {
    } else {
      stroke(c);
      line(loc.x, loc.y, oldLoc.x, oldLoc.y);
    }
  }
  void update() {
    oldLoc = loc.get();
    vel.mult(mag);
    loc.add(vel);
  }
  void feel() {
    l = random(-.3, .3);
    float theta = (float)generator.nextGaussian();
    theta = map(theta * 3, -1, 1, 45, -45);
    dis = PVector.sub(tLoc, loc);
    mag =dis.mag();
    if (mag > 10) {
      dis.normalize();
      dis.mult(l);
      dis.rotate(radians(theta));
      vel = dis.get();
    } else {
      arive = true;
    }
  }
}
