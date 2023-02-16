class Laser{
  float x,y;
  float curDuration;
  float maxDuration;
  float radius;
  
  
  Laser(float x, float y, int charWidth, int charHeight ){
    this.x = x + charWidth/2;
    this.y = y + charHeight/2;
    maxDuration = 120;
    curDuration = 1;
  }
  
  void drawLaser(){
    if(curDuration < maxDuration){
      float alphaVal = curDuration / maxDuration * 150;
      
      noStroke();
      fill(224, 235, 154, 150 - alphaVal); // (213, 195, 255, 150 - alphaVal)
      radius = 40 - curDuration / 5;
      ellipse(x,y, radius, radius);
      
      ++curDuration;
    }
  }
}
