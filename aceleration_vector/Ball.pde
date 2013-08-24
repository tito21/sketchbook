class Ball {
  PVector loc;
  PVector vel;
  PVector acl;
  float max_speed;
  float max_force;

  PVector mouseP;

  float mass;

  Ball(float _locx, float _locy, float _max_speed, float _max_force, float _mass) {
    loc = new PVector(_locx, _locy);
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);
    mouseP = new PVector(mouseX, mouseY);
    mass  = _mass;
    max_force = _max_force;
    max_speed = _max_speed;
  }

  void run() {
    mouseP.set(mouseX, mouseY);
    PVector seek = seek(mouseP);
    PVector sepa = separate();
    seek.mult(2.0);
    sepa.mult(0.5);
    newton(seek);
    newton(sepa);
    update();
    display();
  }

  PVector seek(PVector target) {
    PVector dir = PVector.sub(target, loc);
    if (dir.mag() > 100) {
      dir.normalize();
      dir.mult(max_speed);
    } 
    else {
      float d = map(dir.mag(), 0, 100, 0, max_speed);
      dir.normalize();
      dir.mult(d);
    }
    dir.sub(vel);
   return dir;
  }

  PVector separate() {
    PVector steer= new PVector(0,0);
    int count = 0;
    for (int i = 0; i < balls.size(); i++) {
      Ball b = (Ball) balls.get(i);
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

    void update() {
      vel.add(acl);
      vel.limit(max_speed);
      loc.add(vel);
      acl.mult(0);
    }

    void display() {
      fill(0, 50);
      float theta = vel.heading() + PI/4;
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(theta);
      rect(0, 0, 15*mass, 10*mass);
      popMatrix();
    }

    void newton(PVector force) {
      force.limit(max_force);
      acl.add(force);
      acl.div(mass);
    }
  }

