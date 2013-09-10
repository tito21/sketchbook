class Ant {

  PVector loc;
  PVector vel;
  PVector acl;

  Map map;

  float max_force;
  float max_speed;
  float r;

  Ant(float x, float y, Map _map) {

    map = _map;

    loc = new PVector(map.antH.x, map.antH.y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    acl = new PVector(0, 0);

    max_speed = 2;
    max_force = .03;
    r = 6;

    vel.normalize();
    vel.mult(max_speed);
  }

  void run() {
    PVector point = wander();
    PVector wall = walls();
    PVector a = PVector.add(wall, point);
    a.mult(.5);
     ellipse(a.x, a.y, 10, 10);
    seek(a);
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
    map.mark(loc);
  }

  void seek(PVector target) {
    PVector des = PVector.sub(target, loc);
    des.normalize();
    des.limit(max_speed);
    des.sub(vel);
    newton(des);
  }

  PVector wander() {
    PVector point = vel.get();
    point.normalize();
    point.mult(100);
    point.add(loc);
    float theta = point.heading() + random(-1.3, 1.3);
    PVector target = new PVector(cos(theta)*10, sin(theta)*10); 
    point.add(target);
    point.normalize();
    point.mult(max_speed);
    return point;
  }

  PVector walls() {
    float d = 15;    
    PVector desired = null;

    if (loc.x < d) {
      desired = new PVector(max_speed, vel.y);
    } 
    else if (loc.x > width -d) {
      desired = new PVector(-max_speed, vel.y);
    } 

    if (loc.y < d) {
      desired = new PVector(vel.x, max_speed);
    } 
    else if (loc.y > height-d) {
      desired = new PVector(vel.x, -max_speed);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(max_speed);
    } else {
      desired = new PVector(0, 0);
    }
    desired.normalize();
    return desired;
  }

  void disp() {
    float theta = vel.heading() + PI/2;
    fill(127);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}

