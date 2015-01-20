import processing.serial.*;

Serial myPort;

PImage img;
int r, g, b = 0;

void setup() {
  size(360, 480, P2D);
  img = loadImage("image.jpg");
  image(img, 0, 0);
  
  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
}

void draw() {
  if (myPort.available() > 0) {
   r = myPort.read(); 
  }
  if (myPort.available() > 0) {
   g = myPort.read(); 
  }
  if (myPort.available() > 0) {
   b = myPort.read(); 
  }
  tint(r, g, b);
  image(img, 0, 0);
}
