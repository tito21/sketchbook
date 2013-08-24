class Ant {

  PVector loc;
  PVector vel;
  PVector acl;

  float max_force;
  float max_speed;

  Ant(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);

    max_speed = 10;
    max_force = 3;
  }

  void run() {
    update();
    disp();
  }

  void newton(PVector force) {
    force.limit(max_force);
    acl = force;
  }

  void update() {
    vel.add(acl);
    vel.limit(max_speed);
    loc.add(vel);
    acl.mult(0);
  }

  void seek(PVector target) {
    PVector des = PVector.sub(target,loc);
    des.normalize();
    des.limit(max_speed);
    des.sub(vel);
    newton(des);
  }

  void disp() {
    fill(0);
    ellipse(loc.x, loc.y, 30, 30);
  }
}

