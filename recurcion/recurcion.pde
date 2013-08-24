int c = 0;

void setup() {
  size(500, 500);
  noFill();
  strokeWeight(.5);
  smooth(8);
  ellipseMode(CENTER);
}

void draw() {
  cantor(width/2, height/2, 500);
}

void cantor(float w, float h, float r) {
  if (r > 4) {
   line(w, h, h+r, w);
    cantor(w, r, r/2); 
    cantor(w + r/3, h + r/2, r/2);
    cantor(w + r/3, h + r/2, r/2);
  }
}

