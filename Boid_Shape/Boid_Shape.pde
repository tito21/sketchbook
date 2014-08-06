ArrayList<Creature> lines;
ArrayList<PShape> shapes;

int r = 0;

void setup() {
  size(500, 500);
  background(255);
  stroke(255);
  //frameRate(120);
  shapeMode(CENTER);
  shapes = new ArrayList();
  for (int i = 1; i < 3; i++) {
    shapes.add(loadShape("shape"+i+".svg"));
    shapes.get(i-1).disableStyle();
  }


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
}

void newLine(float locX, float locY) {
  lines.add(new Creature(locX, locY, random(-.1, .1), random(-.1, .1)));
}
void newLine(float locX, float locY, float velX, float velY) {
  lines.add(new Creature(locX, locY, velX, velY));
}

void mousePressed() {
  frame( );
}
void frame() {
 r++;
 saveFrame( );
 if (r > 4) {
 r = 0;
 } else {
 frame();
 }
}
