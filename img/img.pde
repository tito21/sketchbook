PImage img;
PImage des;

void setup() {
  size(360, 480);
  img = loadImage("image.jpg");
  des = createImage(img.width, img.height, RGB);
}

void draw() {
  float threshold = mouseX;
  float br = mouseY;
  img.loadPixels();
  des.loadPixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;


      int pLeft = (x-1) + y*width;


      float r = red(img.pixels[p]);
      float g = green(img.pixels[p]);
      float b = blue(img.pixels[p]);
      
      if (r < threshold) {
        r -= g;
      } else {
        r += g;
      }
      if (g < threshold) {
        g -= b;
      } else {
        g += b;
      }
      if (b < threshold) {
        b -= br;
      } else {
        b += br;
      }
      /*color bL = img.pixels[pLeft];
      float dif = b + bL;
      b = r + dif;*/
     
      des.pixels[p] = color(r, g, b);
    }
  }
  des.updatePixels();
  image(des, 0, 0);
}

