PImage img;

void setup() {
  size(360, 480);
  noStroke();
  img = loadImage("image.jpg");
  img.loadPixels();
}

void draw() {
  fill(img.get(mouseX, mouseY));
  ellipse(mouseX, mouseY, 16, 16);
}
