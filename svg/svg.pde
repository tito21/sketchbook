ArrayList<PShape> shapes; 
int[] colors;

void setup() {
  noLoop();
  size(640, 640);
  strokeWeight(5);
  background(75);
  shapes = new ArrayList<PShape>();
  String[] list = loadStrings("colors");
  colors = new int[list.length];
  if (list != null) {
    for (int i = 0 ; i < list.length; i++) {
      int c = unhex(list[i]);
      color tmp = color((c >> 16) & 0xFF, (c >> 8) & 0xFF, c & 0xFF);
      colors[i] = tmp;
    }
  }
  for (int i = 1; i < 11; i++) {
    shapes.add(loadShape("shape"+i+".svg"));
    shapes.get(i-1).disableStyle();
  }
}

void draw() {
  for (int i = 0; i < 16; i++) {
    for (int j = 0; j < 16; j++) {
      pushMatrix();
      translate(i*40, j*40);
      scale(.125);
      int times = (int)random(2, 10);
      for (int k = 0; k < times; k++) {
        fill(getRandomColor());
        shape(getRandomShape(), 0, 0);
      }
      popMatrix();
    }
  }
}

PShape getRandomShape() {
  int r = (int)random(0, shapes.size());
  return shapes.get(r);
}

color getRandomColor() {
  int c = (int)random(0, colors.length);
  return colors[c];
}

