ArrayList branches;
float l = 20;

//0587
void setup() {
  size(500, 500);
  background(255);
  branches = new ArrayList();
  branches.add(new Branch(l));
}

void draw() {
  for (int i = 0; i < branches.size(); i++) {
    Branch s = (Branch) branches.get(i);
    s.disp();
    s.update();
  }
}

void mouseClicked() {
  branches.add(new Branch(l));
}

  class Branch {

    float newX;
    float newY;
    float lastX;
    float lastY;
    float l;

    Branch(float _l) {
      l = _l;
      lastX = mouseX;
      lastY = mouseY;
      newX = lastX + random(-l, l);
      newY = lastY + random(-l, l);
    }

    void disp() {
      stroke(0);
      line(lastX, lastY, newX, newY);
    }
    void update() {
      lastX = newX;
      lastY = newY;
      newX = lastX + random(-l, l);
      newY = lastY + random(-l, l);
      constrain(newX, width, 0);
      constrain(newY, height, 0);
    }
  }

