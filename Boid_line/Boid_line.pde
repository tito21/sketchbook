ArrayList lines;

void setup() {
  size(500*2, 500*2);
  background(255);
  stroke(255);
  //frameRate(120);
  lines = new ArrayList();
  for (int i = 0; i > 50; i++) {
    newLine(random(width), random(height));
  }
  smooth(4);
}

void draw() {
  fill(0, 10);
  rect(-1, -1, width+1, height+1);
  //background(255);

  if (frameCount % 2 == 0) {
    newLine(random(width), random(height));
  }

  for (int i = 0; i < lines.size (); i++) {
    Creature b = (Creature) lines.get(i); 
    b.run();
    if (b.dead()) lines.remove(i);
  }
  if (frameCount > 500) saveFrame();
}

void newLine(float locX, float locY) {
  lines.add(new Creature(locX, locY, random(-.1, .1), random(-.1, .1)));
}
void newLine(float locX, float locY, float velX, float velY) {
  lines.add(new Creature(locX, locY, velX, velY));
}

void mousePressed() {
  lines.add(new Creature(mouseX+random(-30, 30), mouseY+random(-30, 30), random(-.1, .1), random(-.1, .1)));
}
