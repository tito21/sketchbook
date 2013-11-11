byte[] img;
PImage des;

void setup() {
  size(360, 360);
  img = loadBytes("image.gif");
  //img = subset(img, 8);
  des = createImage(width, height, RGB);
}

void draw() {
  des.loadPixels();
  for (int i = img.length -1 ; i > 3; i-=3) {
    int valueR = byte(img[i]);
    int valueG = byte(img[i-1]);
    int valueB = byte(img[i-2]);
    des.pixels[i] = color(valueR, valueG, valueB);
  }
des.updatePixels();
image(des, 0, 0, width, height);
}
