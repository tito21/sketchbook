float steps = 0.1;
float noise = 0;
float n = 0;
int res = 30;

Mesh grid;

void setup() {
  size(600, 600, P3D);
  frameRate(10);
  grid = new Mesh(width/res, height/res, res);
}

void draw() {
  background(200);
  camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  for (int i = 0; i < grid.x; i++) {
    for (int j = 0; j < grid.y; j++) {
      n += steps;
      noise = noise(n*i, n*j);
      grid.extrude(i, j, noise*100);
    }
  }  
  grid.disp();
}
