Physics  ball;
float s = 10;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
  ball = new Physics(width/2, height/2, s);

  ball.windOn(2, .01);
  ball.gravityOn(1, .1);
  ball.dragOn(.01);
  ball.wrap();
}

void draw() {
  background(25);
  pushMatrix();
  ball.update();
  translate(ball.loc.x, ball.loc.y);
    noStroke();
  ellipse(0, 0, s, s);
  popMatrix();
}
