class Mesh {

  PVector[][] points;
  color[][] colors;
  
  int x;
  int y;
  int steps;

  Mesh(float _x, float _y, int _steps) {
    x = int(_x);
    y = int(_y);
    steps = _steps;
    points = new PVector[x][y];
    colors = new color[x][y];
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        colors[i][j] = color(255);
        points[i][j] = new PVector(i*steps, j*steps, 0);
      }
    }
  }

  void extrude(int posX, int posY, float z) {
    points[posX][posY].set(posX, posY, z);
  }
  
  void setColor(int posX, int posY, color c) {
    colors[posX][posY] = c;
  }

  void disp() {
    for (int i = 0; i < x-1; i++) {
      for (int j = 0; j < y-1; j++) {
        fill(colors[i][j]);
        beginShape();
        vertex(i*steps, j*steps, points[i][j].z);
        vertex((i+1)*steps, (j)*steps, points[i+1][j].z);
        vertex((i+1)*steps, (j+1)*steps, points[i+1][j+1].z);
        vertex((i)*steps, (j+1)*steps, points[i][j+1].z);        
        endShape(CLOSE);
      }
    }
  }
}

