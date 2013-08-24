Paddle pl1;
Paddle pl2;
Ball ball;
float bpos;

void setup() {
  size(500, 300);
  fill(255);
  noStroke();
  rectMode(CENTER);
  pl1 = new Paddle(width/2, height-50, false);
  pl2 = new Paddle(width/2, 25, true);
  ball = new Ball(width/2, height/2, 3);
}

void draw() {
  background(0);
  lineCenter();
  ball.disp();
  pl1.disp();
  pl2.disp();
  pl1.move();
  pl2.move();
  bpos = ball.move(bpos);
}

void lineCenter(){
  for (int i=0; i>width; i+=10) {
    rect(i, height/2, 10, 30);
  }
} 
    
class Ball {
  float bX;
  float bY;
  float s;
 
  Ball(float bX_, float bY_, float s_){
  bX = bX_;
  bY = bY_;
  s  = s_;
  }
  
  void disp() {
    ellipse(bX, bY, 30,30);
  }
  void move(float bX){
    bX = bX + s;
    return bX;
  }   
}
    

class Paddle {
  float posX;
  float posY;
  boolean enm;
  
  Paddle(float  posX_, float posY_, boolean enm_){
    posX = posX_;
    posY = posY_;
    enm = enm_;
    
  }
  void disp(){
    rect(posX, posY, 100, 10);
  }
  void move(){
    if (!enm){
      posX = mouseX;
    }else {
      posX = bpos;
    }
    
  }
}
