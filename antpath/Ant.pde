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
    max_force = .3;
    r = 6;

    vel.normalize();
    vel.mult(max_speed);
  }

  void run() {
    PVector wander = wander();
    PVector front = getInFront();
    wander.mult(1.0);
    front.mult(3.0);

    newton(front);
    newton(wander);

    update();
    borders();
    disp();
    map.mark(loc);
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

  PVector seek(PVector target) {
    PVector des = PVector.sub(target, loc);
    des.normalize();
    des.limit(max_speed);
    des.sub(vel);
    return des;
  }

  PVector wander() {
    float radius = 40;
    float dis = 30;
    float angleX = .5;
    float angle = vel.heading() + random(-angleX, angleX); 

    PVector point = vel.get();
    point.mult(dis);
    point.add(loc);

    PVector target = new PVector(radius*cos(angle), radius*sin(angle));
    target.add(point);
    /*/
     line(loc.x, loc.y, point.x, point.y);
     noFill();
     ellipse(point.x, point.y, radius, radius);
     fill(100);
     ellipse(target.x, target.y, 10, 10);
    /*/
    return seek(target);
  }

  PVector getInFront() {
    PVector point = vel.get();
    point.mult(4*r);
    point.add(loc);
    float value = map.getValue(point);
    PVector front = point.get(); 
    front.normalize();
    front.mult(value);

    line(loc.x, loc.y, point.x, point.y);
    fill(0, 255, 0, value + 25);
    ellipse(point.x, point.y, 5, 5);

    return seek(front);
  }

  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  void disp() {
    float theta = vel.heading() + PI/2;
    fill(103, 80, 65);
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

