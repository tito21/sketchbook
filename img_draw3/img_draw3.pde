PImage img;
PImage des;

void setup() {
  size(360, 480);
  img = loadImage("image.jpg");
  des = createImage(img.width, img.height, RGB);
  img.loadPixels();
  des.loadPixels();
  edge();
}

void draw() {
  float threshold = 10; //map(mouseX, 0, width, 0, 50);
  float br = mouseY;
  img.loadPixels();
  des.loadPixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      color c = img.pixels[p]; 
      int pLeft = (x-1) + y*width;
      color cL = img.pixels[pLeft];

      float r = red(img.pixels[p]);
      float g = green(img.pixels[p]);
      float b = blue(img.pixels[p]);

      if (diff > threshold) {
        des.pixels[p] = color(255);
      } else {
        des.pixels[p] = color(r, g, b);
      }
    }
  }
  des.updatePixels();


  image(des, 0, 0);
}

void edge() {
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      color c = img.pixels[p]; 
      int pLeft = (x-1) + y*width;
      color cL = img.pixels[pLeft];

      float diff = abs(brightness(c) - brightness(cL));
      
      if (diff > 10) {
        des.pixels[p] = color(255);
      } else {
        des.pixels[p] = color(r, g, b);
      }
    }
  }
  des.updatePixels();
}

