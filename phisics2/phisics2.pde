Ballon[] ball = new Ballon[20];
float t = 2;
PVector wind;


void setup() {
  size(500, 300);
  noStroke();
  frameRate(30);
  for (int i = 0; i > 20; i++) {
   ball[i] = new Ballon(random(1,3));
  } 
}

void draw() {
  fill(255, 10);
  rect(0, 0, width, height);
  for (int i = 0; i > 20; i++) {
    ball[i].forceCal();
    ball[i].move();
    ball[i].checkCol();
    ball[i].disp();
  }
  t += 1;
}

class Ballon {

  PVector loc;
  PVector vel;
  PVector acl;
  PVector force;
  PVector w;
  PVector pull;
  float mass;

  Ballon(float _mass) {
    mass = _mass;
    loc = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);
    w = new PVector(0, .2);
    pull = new PVector(0, -.47);
    force = new PVector(0, 0);
  }

  void move() {
    vel.add(acl);
    loc.add(vel);
    acl.mult(0);
    force.mult(0);
  }

  void forceCal() {
    wind = new PVector(noise(t), noise(t+1000));
    wind.normalize();
    wind.mult(.3);
    force.add(w);
    force.add(wind);
    force.add(pull);
    force= PVector.div(force, mass);
    acl.add(force);
  }

  void checkCol() {
    if (loc.x > width) {
      loc.x = width;
    } 
    else if (loc.x < 0) {
      loc.x  = 0;
    }

    if (loc.y > height) {
      loc.y = height;
    } 
    else if (loc.y < 0) {
      loc.y = height;
    }
  }


  void disp() {
    fill(0,10);
    ellipse(loc.x, loc.y, 10*mass, 10*mass);
  }
}

