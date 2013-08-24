//A class for a random walker that tendes to go to a particular place
//
//by: Alberto Di Biase
//
class Branch {

  PVector loc;
  PVector vel;
  PVector acl; 
  PVector tLoc;
  PVector oldLoc;
  PVector dis;
  color c;
  PImage image;

  Branch(float posX, float posY, color _c, PImage _img) {
    loc = new PVector(posX, posY);
    vel = new PVector(0, 0);
    acl = new PVector(0, 0);
    dis = new PVector(0, 0);
    tLoc = new PVector(loc.x, loc.y);
    oldLoc = new PVector(loc.x, loc.y);
    c = _c;
    image = _img;
    getNewTarget();
  }

  void disp() {
    //stroke(c);
    //line(loc.x, loc.y, oldLoc.x, oldLoc.y);

    fill(c,50);
    ellipse(loc.x, loc.y, 5, 5);
  }
  void newton(PVector force) {
    force.limit(.3);
    acl.add(force);
  }
  void update() {
    oldLoc = loc.get();
    vel.add(acl);
    loc.add(vel);
    acl.mult(0);
  }
  void feel() {
    dis = PVector.sub(tLoc, loc);
    if (dis.mag() < 2) {
      getNewTarget();
    } else {
      dis.normalize();
      dis.mult(1.5);
      PVector seek = PVector.sub(dis, vel);
      seek.limit(15);
      newton(seek);
    }
  }
  void getNewTarget() {
    while (true) { //  metodo Montecarlo para distribucion no uniforme

        int x = constrain(round(random(-30, 30) + loc.x), 0, width);
      int y = constrain(round(random(-30, 30) + loc.y), 0, height);

      int l = round(map(brightness(image.get (x, y)), 0, 255, 0, 30));

      int proX = x*l;
      int proY = y*l;

      int xN = round(constrain(random(1), 0, width));
      int yN = round(constrain(random(1), 0, height));

      if (xN < proX && yN < proY) {
        fill(255, 0, 0);
        noStroke();   
        //ellipse(x, y, 5, 5);
        tLoc.set(x, y, 0);
        break;
      }
    }
  }
}

