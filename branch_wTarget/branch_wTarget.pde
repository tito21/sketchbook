ArrayList branches;

PImage img;

//0587 Felipe<3
void setup() {
  size(360, 480);
  background(255);
  ellipseMode(CENTER);
  rectMode(CENTER);
  //smooth(2);
  fill(0, 0, 150);
  img = loadImage("test2.jpg");
  //image(img, 0, 0);
  branches = new ArrayList();
}

void draw() {
  for (int i = 0; i < branches.size(); i++) {
    Branch s = (Branch) branches.get(i);
    s.disp();
    s.update();
    s.feel();
  }
}

void mouseClicked() {
  branches.add(new Branch(width/2, height/2, color(0), img));
}
