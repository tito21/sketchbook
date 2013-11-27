class Mesh {

  PVector[][] points;

  int x;
  int y;
  int steps;

  Mesh(float _x, float _y, int _steps) {
    x = int(_x);
    y = int(_y);
    steps = _steps;
    points = new PVector[x][y];
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        points[i][j] = new PVector(i*steps, j*steps, 0);
      }
    }
  }

  void extrude(int posX, int posY, float z) {
    points[posX][posY].set(posX, posY, z);
  }

  void disp() {

    for (int i = 0; i < x-1; i++) {
      for (int j = 0; j < y-1; j++) {
        beginShape();
        vertex(i*steps+5, j*steps+5, points[i][j].z+5);
        vertex((i+1)*steps+5, (j)*steps+5, points[i+1][j].z+5);
        vertex((i+1)*steps+5, (j+1)*steps+5, points[i+1][j+1].z+5);
        vertex((i)*steps+5, (j+1)*steps+5, points[i][j+1].z+5);        
        endShape(CLOSE);
      }
    }
  }
}

