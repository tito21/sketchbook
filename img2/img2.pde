PImage img;
int[] colors;

void setup() {
  size(600, 400, P2D);
  blendMode(ADD);
  noFill();
  img = loadImage("zorro.png");
  colors = new int[width*height];
  background(0);
  noLoop();
}

void draw() {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    int c = img.pixels[i];
    colors[i] = c;
  }
  for (int x = 0; x < img.width; x+=10) {
    for (int y = 0; y < img.height; y+=10) {
      float a = random(-10, 10);
      float b = random(-10, 10);
      float c = random(-10, 10);
      float d = random(-10, 10);
      float e = random(-10, 10);
      float f = random(-10, 10);
      float g = random(-10, 10);
      float h = random(-10, 10);
      
      stroke(colors[x+y*width]);
      strokeWeight(2); 
      bezier(a+x, b+y, c+x, d+y, x+e, y+f, x+g, y+h);
      stroke(colors[x+y*width], 15);
      strokeWeight(10);
      bezier(a+x, b+y, c+x, d+y, x+e, y+f, x+g, y+h);
    }
  }
}
