class Physics {

  PVector loc;
  PVector vel;
  PVector acl;
  PVector force;
  float mass;

  //Constants
  PVector g;
  PVector windDir; // wind
  float t;
  PVector orbiter;


  //Options
  Boolean gravity;
  Boolean wrap; 
  Boolean orbit;
  Boolean wind;
  Boolean drag;

  //Wieghts
  float gravityW;
  float wrapW;
  float orbitW;
  float windW;
  float dragW;

  Physics(float x, float y, float _mass) {
    mass = _mass;
    loc = new PVector(x, y);
    vel = PVector.random2D();
    acl = new PVector(0, 0);
    force = new PVector(0, 0);

    g = new PVector(0, .1);
    t = 5;
    wrap = false;
    gravity = false;
    orbit = false;
    wind = false;
    drag = false;

    gravityW = 1;
    wrapW = 1;
    orbitW = 1;
    windW = 1;
    dragW = 1;
  }

  void update() { // Main loop
    forceCal();
    vel.add(acl);
    loc.add(vel);
    acl.mult(0);
    force.mult(0);
    dispVector(vel, 100);
    if (wrap) {
      checkCol();
    }
  }

  void newton(PVector force) {
    PVector.div(force, mass, acl);
  }

  void forceCal() {
    if (gravity) {
      PVector gravity = PVector.mult(g, mass);
      newton(PVector.mult(gravity, gravityW));
    }
    if (orbit) {
    }
    if (wind) {
      windDir = new PVector(noise(t), noise(t+1000));
      windDir.normalize();
      windDir.mult(windW);
      dispVector(windDir, 100);
      newton(windDir);
    }
    if (drag) {
      PVector dargforce = PVector.mult(vel, -1);
      dargforce.mult(dragW);
      newton(dargforce);
    }
  }

  void checkCol() {
    if (loc.x > width) {
      loc.x = 0;
    } else if (loc.x < 0) {
      loc.x  = 0;
    }
    if (loc.y > height) {
      loc.y = 0;
    } else if (loc.y < 0) {
      loc.y = height;
    }
  }
  void dispVector(PVector v, float s) {
    pushMatrix();
    stroke(0, 0, 255);
    translate(loc.x, loc.y);
    line(0, 0, v.x*s, v.y*s);
    popMatrix();
  }
  
  // Utils
  PVector getLoc() {
    return loc;
  }
  void wrap() {
    wrap = !wrap;
  }
  void gravityOn() {
    gravity = !gravity;
  }
  void gravityOn(float _g) {
    gravity = true;
    g.set(.0, _g);
  }
  void gravityOn(float _g, float w) {
    gravity = true;
    g.set(.0, _g);
    gravityW = w;
  }
  void windOn() {
    wind = !wind;
  }
  void windOn(float _t) {
    wind = true;
    t =_t;
  }
  void windOn(float _t, float w) {
    wind = !wind;
    t =_t;
    windW = w;
  }
  void orbitOn() {
    orbit = !orbit;
  }
  void dragOn() {
    drag = !drag;
  }
  void dragOn(float w) {
    drag = !drag;
    dragW = w;
  }
}
