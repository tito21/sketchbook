PVector loc;
PVector vel;
PVector acl;

float max_speed;
float max_force;

void setup() {
  ellipseMode(RADIUS);

  size(500, 500);
  loc = new PVector(width/2, height/2);
  vel = new PVector(random(2), random(2));
  acl = new PVector(0, 0);

  max_speed = .5;
  max_force = 2;
}

void draw() {
  background(255);

  PVector wall = walls();
  PVector wander = wander();

  wander.mult(1.0);
  wall.mult(1.0);

  newton(wall);
  newton(wander);

  vel.add(acl);
  vel.limit(max_speed);
  loc.add(vel);
  acl.mult(0);

  disp();
}


void newton(PVector force) {
  force.limit(max_force);
  acl = force;
}

PVector walls() {
  float d = 100;    
  boolean past = false;

  stroke(175);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, width-d*2, height-d*2);
  fill(50);
  PVector point = vel.get();
  point.mult(250);
  point.add(loc);

  if (point.x < d) {
    point = PVector.mult(vel, -1);
    past = true;
  } 
  else if (point.x > width -d) {
    point = PVector.mult(vel, -1);
    past =true;
  } 

  if (point.y < d) {
    point = PVector.mult(vel, -1);
    past = true;
  } 
  else if (point.y > height-d) {
    point = PVector.mult(vel, -1); 
    past = true;
  } 

  if (past) {
    fill(0);
    ellipse(point.x, point.y, 10, 10);
    point.add(loc);
    point.mult(max_speed);
    line(loc.x, loc.y, point.x, point.y);
    ellipse(point.x, point.y, 10, 10);
    point = new PVector(width/2, height/2);
    ellipse(point.x, point.y, 10, 10);
    point = seek(point);
    ellipse(point.x, point.y, 10, 10);
    return point;
  }
  else { 
    return new PVector(0, 0);
  }
}

PVector seek(PVector target) {
  PVector des = PVector.sub(target, loc);
  des.normalize();
  des.limit(max_speed);
  des.sub(vel);
  return des;
}

PVector wander() {
  float radius = 20;
  float dis = 100;
  float angleX = 1;
  float angle = vel.heading() + random(-angleX, angleX); 

  PVector point = vel.get();
  point.mult(dis);
  point.add(loc);

  PVector target = new PVector(radius*cos(angle), radius*sin(angle));
  target.add(point);


  line(loc.x, loc.y, point.x, point.y);
  noFill();
  ellipse(point.x, point.y, radius, radius);
  fill(100);
  ellipse(target.x, target.y, 10, 10);

  return seek(target);
}

void disp() {
  float r = 6;
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

