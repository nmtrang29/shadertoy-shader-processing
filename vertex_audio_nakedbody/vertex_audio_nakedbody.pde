import peasy.*;
import ddf.minim.analysis.*;
import ddf.minim.*;

PeasyCam cam;;
Minim minim;  
AudioInput in;
FFT fftLog;
PImage fftimg;
PShape body;
PShader fx;
int numBands;
float biggest;

void setup() {
  size(600, 600, P3D);
  noStroke();
  
  fx = loadShader("frag.glsl", "vert.glsl");
  //fx = loadShader("vert.glsl");
  body = loadShape("matt.obj"); 
  
  minim = new Minim(this);
  in = minim.getLineIn();

  fftLog = new FFT(in.bufferSize(), in.sampleRate());
  fftLog.logAverages( 22, 3 );
  
  numBands = fftLog.avgSize();
  println("There are", numBands, "bands");
  // Create a 30x1 pixels image.
  fftimg = createImage(numBands, 1, ARGB);
  
  cam = new PeasyCam(this, 180);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(400);
  cam.setSuppressRollRotationMode();
  cam.setRotations(3.2, 3.2, 0);
  cam.setWheelScale(0.1);
}

void draw() {
  background(255);
  fftLog.forward( in.mix );

  // Convert FFT values into colors of pixels
  fftimg.loadPixels();
  for (int i = 0; i < numBands; i++) {
    float theval = fftLog.getAvg(i);
    // Here we set one of the pixels to contain
    // one FFT  value
    fftimg.pixels[i] = color(theval * 5);
  }
  fftimg.updatePixels();
  
  // Send the fft image texture to the GPU
  fx.set("fft", fftimg);
  fx.set("time", millis()/1000.0);
  
  // Enable  the shader
  shader(fx);
  // Move to the center of the screen
   translate(0,-80,0);
  background(0);
  lights();
  shape(body, 0, 0);
}
