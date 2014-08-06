import processing.video.*;

Capture cam;

int res = 2;

void setup() {
  size(648, 480, P3D);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i+" "+cameras[i]);
    }
    cam = new Capture(this, cameras[1]); 
    cam.start();
    
    noStroke();
  }
}

void draw() {

  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    background(255);
    camera(mouseX + width/2, mouseY + height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
    for (int i = 0; i < width/res; i++) {
      for (int j = 0; j < height/res; j++) {
        color c = cam.pixels[(i+res) + (j+res)*width];
        float p = brightness(c);
        fill(c);
        pushMatrix();       
        translate(i*res, j*res, 0);
        box(res, res, p);
        popMatrix();
      }
    }
  }
}
