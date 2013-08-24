int maxX = 700;
int maxY = 500;
void setup() {
  size(maxX, maxY);
  background(#FFAA00);
  stroke(255);
} 

void draw() {
  if (mousePressed) {
    line (mouseX, mouseY, random(maxX+1), random(maxY+1));
  } else {
    background(#FFAA00);
  }
}
