PImage img;
PImage des;

void setup() {
  size(360, 480, P2D);
  frameRate(30);
  img = loadImage("image.jpg");
  des = createImage(img.width, img.height, RGB);
}

void draw() {
  //image(img, 0,0);
  background(200);
  float threshold = map(mouseX, 0, width, 0, 30);
  float br = mouseY;
  img.loadPixels();
  des.loadPixels();

  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      int pLeft = (x-1) + y*width;
      float c = brightness(img.pixels[p]);
      float cLeft = brightness(img.pixels[pLeft]); 

      float diff = abs((c - threshold) - cLeft);

      float r = red(img.pixels[p]);
      float g = green(img.pixels[p]);
      float b = blue(img.pixels[p]);

      des.pixels[p] = color(diff);
    }
  }
  des.updatePixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int p = x + y*width;
      float l = brightness(des.pixels[p]);
      if (l > 30) {
        line(x+random(-7, 7), y+random(-7, 7), x+random(-1, 1), y+random(-1, 1));
      }
    }
  }
}

