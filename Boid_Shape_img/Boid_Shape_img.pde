ArrayList<Creature> lines;
ArrayList<PShape> shapes;
color[] colors;
int r = 0;

void setup() {
  size(700, 500);
  background(255);
  stroke(255);
  strokeWeight(5);
  fill(0);
  shapeMode(CENTER);
  shapes = new ArrayList();
  for (int i = 1; i < 7; i++) {
    shapes.add(loadShape("shape"+i+".svg"));
    shapes.get(i-1).disableStyle();
  }
  String[] list = loadStrings("colors");
  colors = new int[list.length];
  if (list != null) {
    for (int i = 0; i < list.length; i++) {
      int c = unhex(list[i]);
      int tmp = color((c >> 16) & 0xFF, (c >> 8) & 0xFF, c & 0xFF);
      colors[i] = tmp;
    }
  }

  lines = new ArrayList();
  for (int i = 0; i > 50; i++) {
    newLine(width/2, height-i*5);
  }
  smooth(4);
}

void draw() {
  //fill(0, 10);
  //rect(-1, -1, width+1, height+1);
  //background(255);
  if (frameCount > 800) { 
    saveFrame("img" + round(random(100))); 
    noLoop();
  }
  if (frameCount % 10 == 0) {
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
