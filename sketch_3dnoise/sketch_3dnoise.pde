float steps = 0.1;
float res = 5;
float noise;
float n;

void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(255);
  camera(mouseX + width/2, mouseY + height/2, (height/2) / tan(PI/6), width/2, height/2 , 0, 0, 1, 0);
  n += steps;
  for (int i = 0; i < width/res; i++) {
    for (int j = 0; j < height/res; j++) {
      noise = noise(n + i, n + j);
      stroke(random(0, 255), random(0, 255), random(0, 255));
      beginShape(LINES);
      vertex(i*res, j*res, 0);
      vertex(i*res, j*res, 50*noise);
      endShape();
    }
  }
}

