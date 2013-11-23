byte[] img;
PImage des;

String filename = "image";
String[] format = { 
  ".jpg", ".tif", ".gif", ".bmp", ".png"
};
int fm;

void setup() {
  size(1024, 1024);
  fm = 2;
  
  img = loadBytes(filename + format[fm]);
  des = createImage(width, height, RGB);
}

void draw() {
  background(0);
  des.loadPixels();
  for (int i = img.length -1 ; i > 3; i-=3) {
    int valueR = img[i] &  0xff;
    int valueG = img[i-1] &  0xff;
    int valueB = img[i-2] &  0xff;
    des.pixels[i] = color(valueR, valueG, valueB);
  }ss
  des.updatePixels();
  image(des, 0, 0, width, height);
}

void keyReleased() {
  if (key == 's') {
    des.save("output_" + filename + format[fm] + ".tif");
    println("File Saved");s
  }
}
