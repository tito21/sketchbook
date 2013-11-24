float steps = 0.05;
float res = 10;
float noise;
float n;

void setup() {
  size(500, 500, P3D);
  colorMode(HSB);
  frameRate(30);
}

void draw() {
  background(255);
  camera(mouseX + width/2, mouseY + height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  n += steps;
  for (int i = 0; i < width/res; i++) {
    for (int j = 0; j < height/res; j++) {
      noise = noise(n + i, n + j);
      fill(noise*255, 255, 255);
      pushMatrix();       
      translate(i*res, j*res, 0);
      box(10, 10, noise*100);
      popMatrix();
    }
  }
}

