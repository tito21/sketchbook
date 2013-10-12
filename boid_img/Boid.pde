class Ball {
  PVector loc;
  PVector vel;
  PVector acl;
  float max_speed;
  float max_force;
  
  PImage img;
  PVector mouseP;

  float mass;

  Ball(float _max_speed, float _max_force, float _mass, PImage _img) {
    loc = new PVector(mouseX+ random(-30, 30), mouseY+random(-30, 30));
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);
    mouseP = new PVector(mouseX, mouseY);
    img = _img;
    mass  = _mass;
    max_force = _max_force;
    max_speed = _max_speed;
  }

  void run() {
    mouseP.set(mouseX, mouseY);
    PVector seek = seek(mouseP);
    PVector sepa = separate();
    seek.mult(2.5);
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
      float theta = vel.heading();
      pushMatrix();
      translate(loc.x, loc.y);
      rotate(theta);
      image(img, 0, 0, 20*mass, 20*mass);
      popMatrix();
    }

    void newton(PVector force) {
      force.limit(max_force);
      acl.add(force);
      acl.div(mass);
    }
  }

