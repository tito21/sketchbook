class Map {
  PVector antH;
  PVector food;
  float[][] grid;

  int res;
  int rows;
  int colms;

  Map() {
    antH = new PVector(width/2, height/2);
    food = new PVector(random(width), random(height));

    res = 10;

    rows = round(width/res);
    colms = round(height/res); 

    grid = new float[rows][colms];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < colms; j++) {
        grid[i][j] = 0;
        line(i*res, 0, i*res, height);
        line(0, j*res, width, j*res);
      }
    }
  }

  void disp() {

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < colms; j++) {
        if (grid[i][j] > 0) {
          fill(map(grid[i][j], 0, 50, 255, 0));
          rect(i*res, j*res, res, res);
        }
      }
    }
    fill(#ff0000);
    rect(antH.x, antH.y, 50, 50);
    fill(#00ffff);
    ellipse(food.x, food.y, 50, 50);
  }

  void mark(PVector loc) {
    int locX = floor(loc.x/res);
    int locY = floor(loc.y/res);

    locX = constrain(locX, 0, rows-1);
    locY = constrain(locY, 0, colms-1);

    grid[locX][locY] += 1;
  }
}

