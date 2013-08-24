Branch branches[];
float newX = width/2;
float newY = width/2;
float lastX = width/2;
float lastY = width/2;
//0587
void setup() {
  size(500, 500);
  frameRate(30);
  branches = new Branch[5];
  for (Branch i : branches) {
    i = new Branch();
  }
}

void draw() {
  print("hi ");
  for (Branch i : branches) {
    i.disp();
  }
}


class Branch {

  float newX;
  float newY;
  float lastX;
  float lastY;

  Branch() {
    lastX = 0;
    lastY = 0;
  }

  void disp() {
    print("linea ");
    stroke(0);
    line(lastX, lastY, width/2, height/2);
  }
}


