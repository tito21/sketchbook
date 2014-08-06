
class Creature {

  PVector loc;
  PVector vel;
  PVector acl;

  float max_speed;
  float max_force;
  float life;
  int shape;

  Creature(float x, float y, float velX, float velY ) {
    loc = new PVector(x, y);
    vel = new PVector(velX, velY);
    acl = new PVector(0, 0);
    newton(new PVector(random(-100, 100), random(-100, 100)));
    max_speed = random(10, 75);
    max_force = random(2, 6);
    life = random(100, 500);
    shape = (int)random(shapes.size());
  }

  void update() {
    life--;
    PVector wander = wander();
    PVector separate = separate();
    separate.mult(1);
    wander.mult(1);
    newton(separate);
    newton(wander);
    vel.add(acl);
    vel.limit(max_speed);
    loc.add(vel);
    acl.mult(0);
  }

  void run() {
    update();
    if (frameCount % 10 == 0) {
      display();
    }
  }

  void display() {
    float theta = vel.heading();
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    //fill(colors[(int)random(0, colors.length)], life);
    //line(0, 0, 0, 0);
    if (random(1) > .2) {
      fill(0);
      stroke(255);
    } else {
      stroke(0);
      fill(255);
    }
    scale(life*.0005);
    shape(shapes.get(shape), loc.x, loc.y);
    popMatrix();
  }

  PVector seek(PVector target) {
    //PVector target = new PVector(x, y);
    PVector dis = PVector.sub(target, loc);
    dis.sub(vel);
    dis.normalize();
    dis.mult(max_speed);
    return dis;
  }
  PVector wander() {
    float radius = 50;
    float dis = 300;
    float angleX = 3;
    float angle = vel.heading() + random(-angleX, angleX); 

    PVector point = vel.get();
    point.mult(dis);
    point.add(loc);

    PVector target = new PVector(radius*cos(angle), radius*sin(angle));
    target.add(point);

    //    line(loc.x, loc.y, point.x, point.y);
    //    noFill();
    //    ellipse(point.x, point.y, radius, radius);
    //    fill(100);
    //    ellipse(target.x, target.y, 10, 10);

    return seek(target);
  }

  PVector separate() {
    PVector steer= new PVector(0, 0);
    int count = 0;
    for (int i = 0; i < lines.size (); i++) {
      Creature b = (Creature) lines.get(i);
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

  Boolean dead() {
    if (life < 0) return true;
    else return false;
  }

  void newton (PVector force) {
    force.limit(max_force);
    acl = force;
  }
}
