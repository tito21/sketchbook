PImage img;
PImage des;

ArrayList <PVector>points;

void setup() {
  size(360, 480);
  frameRate(30);
  points = new ArrayList();
  img = loadImage("image.jpg");
  img.filter(THRESHOLD);
  des = createImage(img.width, img.height, RGB);
  noLoop();
}

void draw() {
  //image(img, 0,0);
  background(255);

  img.loadPixels();
  des.loadPixels();

  for (int x = 0; x < width; x+=1) {
    for (int y = 0; y < height; y+=1) {      
      int p = x + y*width;
      float c = brightness(img.pixels[p]);

      if (c < 128) {
        points.add(new PVector(x, y));
      }
    }
  }
  for (int i = 0; i < 10000; i++) {
    points.remove(int(random(points.size())));
  }
    
  for (PVector p : points) {
    stroke(0,5);
    PVector pn = points.get(int(random(points.size())));
    line(p.x, p.y, pn.x, pn.y);
  }
}
