ArrayList balls;

PImage img;

void setup() {
  size(500, 500);
  rectMode(CENTER);
  img = loadImage("zapa.png");
  noStroke();
  balls = new ArrayList();
  for (int i = 0; i < 10; i ++) {
    balls.add(new Ball(random(1, 12), random(.1, .2), random(.25, 4), img));
  }
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

