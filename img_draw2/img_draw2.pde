PImage img;
PImage des;

void setup() {
  size(360, 480, P2D);
  img = loadImage("image.jpg");
  des = createImage(img.width, img.height, RGB);
}

void draw() {
  background(200);
  float X = map(mouseX, 0, width, 0, 20);
  float Y = map(mouseY, 0, height, 0, 20);
  img.loadPixels();
  des.loadPixels();

  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      int pLeft = (x-1) + y*width;
      float c = brightness(img.pixels[p]);
      float cLeft = brightness(img.pixels[pLeft]); 

      float diff = abs((c - Y) - cLeft);

      des.pixels[p] = color(diff);
    }
  }
  des.updatePixels();
  for (int x = 1; x < width; x++) {
    for (int y = 0; y < height; y++) {      
      int p = x + y*width;
      int pLeft = (x-1) + y*width;
      float c = brightness(des.pixels[p]);
      float cLeft = brightness(des.pixels[pLeft]); 

      float diff = abs((c - X) - cLeft);

      des.pixels[p] = color(diff);
    }
  }
  image(des, 0, 0);
}

void mousePressed() {
  image(img, 0, 0);
}

