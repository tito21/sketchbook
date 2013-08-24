PImage img;
PImage des;
PImage dif;


void setup() {
  size(360, 480);
  img = loadImage("image.jpg");
  des = createImage(img.width, img.height, RGB);
  dif = createImage(img.width, img.height, RGB);
  img.loadPixels();
  des.loadPixels();
  dif.loadPixels();
  diference();
}

void draw() {
  float threshold = mouseX;
  float br = mouseY;
  img.loadPixels();
  des.loadPixels();
  dif.loadPixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      color c = img.pixels[p]; 
      int pLeft = (x-1) + y*width;
      color cL = img.pixels[pLeft];

      float r = red(img.pixels[p]);
      float g = green(img.pixels[p]);
      float b = blue(img.pixels[p]);
     
      if (r > threshold && g < (threshold+50)) {
        r = 255;
        g = 255;
        b = 255;
      }
      
      des.pixels[p] = color(r,g,b);
    }
  }
  des.updatePixels();
  image(des, 0, 0);
}

void diference() {
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      color c = img.pixels[p];
      int pLeft = (x-1) + y*width;
      color cL = img.pixels[pLeft];

      float diff = abs(brightness(c) - brightness(cL));
      if (diff > 13) {
        c = color(0);
      }
      else {
        c = color(255);
      }
      dif.pixels[p] = c;
    }
  }
  dif.updatePixels();
}

