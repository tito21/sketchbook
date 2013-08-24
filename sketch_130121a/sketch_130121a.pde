void setup() {
  size(500, 500);
  noStroke();
  ellipseMode(CENTER);
}
void draw() {
   fill(0,0,random(255), random(255));
  float size = random(30);
  float sIx = randomGaussian()*15;
  float sIy = randomGaussian()*15;
  if (mousePressed) {
   ellipse(mouseX+sIx, mouseY+sIy, size, size); 
  }
}
