class Point {

  PVector loc;
  float radius;

  Point(float x, float y) {
    loc = new PVector(x, y);
    radius = 7.5;
  }

  void disp(int res) {
    ellipse(loc.x*res, loc.y*res, 0, 0);
    for (Point p : points) {
      PVector distance = PVector.sub(p.loc, loc);
      if (distance.mag() < radius) {
        println(distance.mag());
        line(loc.x*res, loc.y*res, p.loc.x*res, p.loc.y*res);
      }
    }
    // detc atheer point and caluate its distance
    // if less than radius then draw a line joing them
  }
}
