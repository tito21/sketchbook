class Map {

  PVector antH;
  PVector food;
  float[][] grid;

  int res;
  int rows;
  int colms;

  Map() {
    res = 10;

    rows = round(width/res);
    colms = round(height/res); 

    antH = new PVector(width/2, height/2);
    food = new PVector(random(rows*res), random(colms*res));

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
    fill(255, 255, 0, 100);
    rect(food.x, food.y, 50, 50);
  }

  void mark(PVector loc) {
    int locX = floor(loc.x/res);
    int locY = floor(loc.y/res);

    locX = constrain(locX, 0, rows-1);
    locY = constrain(locY, 0, colms-1);

    grid[locX][locY] += 1;
  }

  float getValue(PVector loc, PVector vel) {
    int dis = 10;
    int locX = floor(loc.x/res);
    int locY = floor(loc.y/res);

    float value = 0;

    locX = constrain(locX, 0, rows-1);
    locY = constrain(locY, 0, colms-1);

    float line = vel.heading();

    for (int i = 0; i < dis; i++) {
      for (int j = 0; j < dis; j++) { 
        int x = constrain(locX + i, 0, rows-1);
        int y = constrain(locY + j, 0, colms-1);

        value += grid[x][y];
      }
    }
    return (value/(di<<s + dis));
  }
}

