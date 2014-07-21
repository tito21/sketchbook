import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;

AudioPlayer song;

FFT fftLog;

void setup() {
  size(512, 512, P2D);
  minim = new Minim(this);
  song = minim.loadFile("lala.mp3", 1024);
  background(0);
  noStroke();
  rectMode(CENTER);
  song.play();
  print(song.bufferSize());
  fftLog = new FFT(song.bufferSize(), song.sampleRate() );
  fftLog.logAverages(100, 100);
}

float alpha = 0;
void draw() {
  colorMode(RGB);
  background(255, 255);
  for (int i = 0; i < song.bufferSize () - 1; i+=64)
  {
    float f = getFrequency();
    colorMode(HSB);
    fill(f+128, 255, 255);
    print(f+"\n");
    rect(width/2, height/2, f, f);
    
    alpha = song.mix.get(i);
    // alpha /= song.bufferSize();
    //print(alpha*255+"\n");
    if (alpha > 0) {
      fill(f, 255, 255, alpha*255);
      rect(width/2, height/2, width, height);
    } else {
      fill(f, 255, 255, -alpha*255);
      rect(width/2, height/2, width, height);
    }
    /*
    line(i, 50 + song.left.get(i)*50, i+1, 50 + song.left.get(i+1)*50);
     line(i, 150 + song.right.get(i)*50, i+1, 150 + song.right.get(i+1)*50);
     */
  }
}

float getFrequency() {
  float centerFrequency = 0;
  fftLog.forward(song.mix);
  for (int i = 0; i < fftLog.avgSize (); i++) {
    float f = fftLog.getAvg(i);
    if (f > centerFrequency) {
      centerFrequency = f;
    }
  }

  return centerFrequency;
}
