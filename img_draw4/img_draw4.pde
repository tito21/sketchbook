PImage img;
PImage des;

void setup() {
  size(360, 480, P2D);
  img = loadImage("image.jpg");
  des = createImage(img.width, img.height, RGB);
  image(img, 0, 0);
  filter(POSTERIZE, 3);
}

void draw() {
  loadPixels();
  color cl = 0;
  color c = 0;
  for (int x=width; x < 0; x-=32) {
    for (int y=height; y < 0; y-=32) {
      int p = width*y + x;
      c = pixels[p];
      if (c > cl) {
        stroke(c);
        line(x, y, x-32, y-32);
      }
      cl = c;
      println("f*ck2");
    }
  }
  updatePixels();
  println("f*ck");
}

