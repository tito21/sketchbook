ArrayList<PShape> shapes; 
int[] colors;
Arrays array;

void setup() {
  size(640, 640);
  strokeWeight(5);
  noLoop();
  background(255);

  setArrays();

  array = new Arrays(shapes, colors);
}

void draw() {
  background(255);
  scale(.125);
  for (int i = 0; i < 10; i++) {
    translate(i*100, 0);
    stroke(array.getRandomColor(), 0, 0);
    shape(array.getRandomShape(), 0, 0);
  }
}

void mousePressed() {
  draw();
}

void setArrays() {
  shapes = new ArrayList<PShape>();
  String[] list = loadStrings("colors");
  colors = new int[list.length];
  if (list != null) {
    for (int i = 0; i < list.length; i++) {
      int c = unhex(list[i]);
      int tmp = color((c >> 16) & 0xFF, (c >> 8) & 0xFF, c & 0xFF);
      colors[i] = tmp;
    }
  }
  for (int i = 1; i < 3; i++) {
    shapes.add(loadShape("shape"+i+".svg"));
    shapes.get(i-1).disableStyle();
  }
}

