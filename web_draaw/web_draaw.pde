import processing.video.*;

Capture cam;

void setup() { 
  size(532, 400, P2D);
  frameRate(5);
  cam = new Capture(this);
  cam.start(); 
 // img = createImage(width, height, RGB);
 stroke(255);
} 

void draw() { 

  if (cam.available()) { 
    // Reads the new frame
    cam.read();
    float threshold = map(mouseX, 0, width, 0, 120);
    cam.loadPixels();
    //des.loadPixels();
image(cam, 0, 0); 
    for (int x = 1; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int p = x + y*width;
        int pLeft = (x-1) + y*width;
        print("holi ");
        float c = brightness(cam.pixels[p]);
        float cLeft = brightness(cam.pixels[pLeft]);
        float diff = abs((c + threshold) - cLeft);
        ellipse(x, y, 10, 10);
        if (diff > 30) {
          line(x+random(-5, 5), y+random(-5, 5), x, y);
        }
        else {
          print("tranqi ");
        }
      }
    }
  }
}

