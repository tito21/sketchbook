import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;

AudioPlayer song;

void setup() {
  size(512, 512, P2D);
  minim = new Minim(this);
  song = minim.loadFile("lala.mp3", 512);
  background(0);
  stroke(255);
  strokeWeight(2);
  song.play();
}

float newX = width/2;
float newY = height/2;
void draw() {
  
  
  translate(newX, newY);
  //background(0);
  fill(0, 20);
  rect(0, 0, width, height);
  fill(255);
  int i = int(random(511));
  float newX = song.mix.get(i)*512;
  float newY = song.mix.get(i+1)*512;
  translate(newX, newY);
  line(0, 0, newX, newY);


  //for (int i = 0; i < song.mix.size() -1; i+=1) {
  //vertex(i, 150 + song.left.get(i)*100, i+1, 50 + song.left.get(i+1)*100 );
  //line( i, 150 + song.left.get(i)*100, i+1, 50 + song.left.get(i+1)*100 );
  //line( i, 350 + song.right.get(i)*100, i+1, 150 + song.right.get(i+1)*100 );

  //vertex(i, 350 + song.right.get(i)*100, i+1, 150 + song.right.get(i+1)*100 );
  //}
  //endShape(CLOSE);
}

void stop() {
  song.close();
  minim.stop();

  super.stop();
}
