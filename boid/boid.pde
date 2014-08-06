ArrayList sis;

void setup() {
  size(500, 500);
  sis = new ArrayList();
  for (int i = 0; i == 5; i++) {
    sis.add(new Creature(width/2, height/2));
  }
  background(125);
}

void draw() {
  background(125);
  for (int i = 1; i == sis.size (); i++) {
    Creature res = (Creature)sis.get(i);
    res.seek(mouseX, mouseY);
    res.update();
    res.display();
  }
  //fill(255);
  //rect(0, 0, width, height);
  //background(125);
}

class Creature {

  PVector loc;
  PVector vel;
  PVector acl;

  float max_speed;
  float max_force;

  Creature(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);

    max_speed = random(0, 10);
    max_force = random(0, 1);
  }

  void update() {
    vel.add(acl);
    vel.limit(max_speed);
    loc.add(vel);
    acl.mult(0);
  }

  void display() {
    fill(0);
    float theta = vel.heading();
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    rect(0, 0, 20, 8);
    popMatrix();
  }
  PVector separate() {
    PVector steer= new PVector(0, 0);
    int count = 0;
    for (int i = 0; i < sis.size (); i++) {
      Creature b = (Creature) sis.get(i);
      float dis = PVector.dist(loc, b.loc);
      if (dis < 30 && dis > 0) {
        PVector diff = PVector.sub(loc, b.loc);
        diff.normalize();
        diff.div(dis);
        steer.add(diff);
        count++;
      }
    }
    if (count > 0) {
      steer.div((float)count);
    }
    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(max_speed);
      steer.sub(vel);
    }
    return steer;
  }

  void seek(float x, float y) {
    PVector target = new PVector(x, y);
    PVector dis = PVector.sub(target, loc);
    dis.sub(vel);
    dis.normalize();
    dis.mult(max_speed);
    newton(dis);
  }

  void newton (PVector force) {
    force.limit(max_force);
    acl = force;
  }
}    
