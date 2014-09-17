PImage img;

ArrayList<Point> points;

int res = 10;

void setup() {
  size(74*res, 80*res); // Picture
  noLoop();
  background(255);
  strokeWeight(.5);
 // noStroke();
  fill(0);

  img = loadImage("data.png");
  points = new ArrayList();
}

void draw() {
  image(img, 0, 0);
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int c = img.pixels[i + j*img.width];
      if (brightness(c) < .75) {
        points.add(new Point(i, j));
      }
    }
  }
  for (int i = 0; i < points.size (); i++) {
    if (random(1) > 0.01) {
      points.remove(i);
    }
  }
  for (Point p : points) {
    p.disp(res);
  }
  saveFrame("pin"+int(random(100))+".png");
}
