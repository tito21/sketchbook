import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;

AudioPlayer song;

FFT fftLog;

float height3;
float height23;
float spectrumScale = 4;

void setup() {
  size(512, 480, P2D);
  
   height3 = height/3;
  height23 = 2*height/3;

  
  minim = new Minim(this);
  song = minim.loadFile("lala.mp3", 1024);
  background(0);
  noStroke();
  song.play();
  print(song.bufferSize());
  fftLog = new FFT(song.bufferSize(), song.sampleRate() );
  fftLog.logAverages(22, 3);
}

void draw() {
  background(0);
  float centerFrequency = 0;
  
  // perform a forward FFT on the samples in jingle's mix buffer
  // note that if jingle were a MONO file, this would be the same as using jingle.left or jingle.right
  fftLog.forward( song.mix );
 
  // draw the full spectrum
  {
    noFill();
    for(int i = 0; i < fftLog.specSize(); i++)
    {
      // if the mouse is over the spectrum value we're about to draw
      // set the stroke color to red
      if ( i == mouseX )
      {
        centerFrequency = fftLog.indexToFreq(i);
        stroke(255, 0, 0);
      }
      else
      {
          stroke(255);
      }
      line(i, height23, i, height23 - fftLog.getBand(i)*spectrumScale);
    }
    
    fill(255, 128);
    text("Spectrum Center Frequency: " + centerFrequency, 5, height23 - 25);
  }
  
  // no more outline, we'll be doing filled rectangles from now
  noStroke();
  for(int i = 0; i < fftLog.avgSize(); i++)
    {
      centerFrequency    = fftLog.getAverageCenterFrequency(i);
      // how wide is this average in Hz?
      float averageWidth = fftLog.getAverageBandWidth(i);   
      
      // we calculate the lowest and highest frequencies
      // contained in this average using the center frequency
      // and bandwidth of this average.
      float lowFreq  = centerFrequency - averageWidth/2;
      float highFreq = centerFrequency + averageWidth/2;
      
      // freqToIndex converts a frequency in Hz to a spectrum band index
      // that can be passed to getBand. in this case, we simply use the 
      // index as coordinates for the rectangle we draw to represent
      // the average.
      int xl = (int)fftLog.freqToIndex(lowFreq);
      int xr = (int)fftLog.freqToIndex(highFreq);
      
      // if the mouse is inside of this average's rectangle
      // print the center frequency and set the fill color to red
      if ( mouseX >= xl && mouseX < xr )
      {
        fill(255, 128);
        text("Logarithmic Average Center Frequency: " + centerFrequency, 5, height - 25);
        fill(255, 0, 0);
      }
      else
      {
          fill(255);
      }
      // draw a rectangle for each average, multiply the value by spectrumScale so we can see it better
      rect( xl, height, xr, height - fftLog.getAvg(i)*spectrumScale );
    }
}
