ArrayList balls;

void setup() {
  size(500, 500);
  rectMode(CENTER);
  noStroke();
  balls = new ArrayList();
  balls.add(new Ball(mouseX+random(-30, 30), mouseY+random(-30, 30), random(1, 12), random(.1, .2), random(.25, 4)));
  // smooth(2);
}

void draw() {
  //fill(0, 10);
  //rect(0, 0, width, height);
  background(255); //<>//
  for (int i = 0; i < balls.size(); i++) {
    Ball b = (Ball) balls.get(i); 
    b.run();
  }
}

void mousePressed() {
  balls.add(new Ball(mouseX+random(-30, 30), mouseY+random(-30, 30), random(1, 12), random(.1, .2), random(.25, 4)));
}
