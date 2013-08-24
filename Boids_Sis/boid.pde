class Boid {

  PVector loc;
  PVector vel;
  PVector acl;

  float maxSpeed;

  float r = 2; 

  Boid(float x, float y) {
    loc = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(random(10));
    acl = new PVector(0, 0);

    maxSpeed = random(2);
  }

  void run() {
    display();
    update();
  }

  void update() {
    vel.add(acl);
    vel.limit(maxSpeed);
    loc.add(vel);
    acl.mult(0);
  }

  void display() {
    float theta = vel.heading() + radians(90);
    fill(175);
    stroke(0);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    rect(0, 0, 20, 20);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}

