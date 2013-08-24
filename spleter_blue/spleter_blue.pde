void setup() {
  size(500, 500);
  noStroke();
  ellipseMode(CENTER);
  background(255);
}
void draw() {
  float size = random(30);
  float sIx = randomGaussian()*15; // normal distrivueted random numbers for positions
  float sIy = randomGaussian()*15;
  if (mousePressed) {
    fill(0,0,random(255), random(255));
   ellipse(mouseX+sIx, mouseY+sIy, size, size);
  }
}
