PImage img;
byte[] des;

String filename = "output_image";
String[] format = { 
  ".jpg", ".tif", ".gif", ".bmp", ".png"
};
int fm;

void setup() {
  size(1024, 1024);
  fm = 1;
  
  img = loadImage(filename + ".gif" + format[fm]);
  
  des =  new byte[3145728];
}

void draw() {
  background(0);
  img.loadPixels();
  for (int i = img.pixels.length -1 ; i > 03; i--) {
    int valueR = (img.pixels[i] >> 16) &  0xff;
    int valueG = (img.pixels[i] >> 8) &  0xff;
    int valueB = (img.pixels[i]) &  0xff;
    des[i*3] = byte(valueR);
    des[(i*3) + 1] =  byte(valueG);
    des[(i*3) + 2] =  byte(valueB);
  }
  image(img, 0, 0, width, height);
}

void keyReleased() {
  if (key == 's') {
    saveBytes("output_" + filename + format[fm] + ".bmp", des);
    println("File Saved");
  }
}
