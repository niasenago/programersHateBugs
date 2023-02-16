class Bug{
  //members - variables of th object(attributes)
  float x, y;
  PVector speed;
  PImage img;
  int radius = 30;
  PVector topLeft, topRight, bottomLeft, bottomRight;
  
  //constructor - initializes the variables or settings of the object(sets up those attributes)
  Bug(){
    topLeft = new PVector();
    topRight = new PVector();
    bottomLeft = new PVector();
    bottomRight = new PVector();
    
    img = loadImage("beetleDARK.png");
    
    x = random(10, width - 10);
    y = random(10, height - 10);
    
    speed = new PVector(random(-0.5,0.5), random(-0.5,0.5));
  }
  
  //method - functions in the object that the class creates(abilities of the object)
  void drawBug(int [][]level, int tileSize){
    moveBug(level, tileSize);
    
    pushMatrix();
    translate(x + img.width / 2, y + img.height / 2);  //lesson 20
    rotate(speed.heading()+ PI/2);  // in radians 0;2pi
    translate(-img.width / 2, - img.height / 2 );
    
    image(img,0,0);
    
    popMatrix();
  }

  void moveBug(int [][]level, int tileSize){
      float randNum = random(0,1);
      if(randNum < 0.1){
        speed.rotate(random(-0.3, 0.3));
        
      }
      if(randNum > 0.97){
        speed.rotate(random(-1, 1));
        
      }
      if(randNum < 0.05){
        x += speed.x + random(-1,1);
        y += speed.y + random(-1,1);
      }
      
      x += speed.x;
      y += speed.y;
      
      if(isBugOffScreen() || isBugInWall(level, tileSize)){
        x -= speed.x;
        y -= speed.y;
        speed.rotate(random(-2,2));
      }
      
  }
  
  boolean isBugOffScreen(){
    //int radius = 30;
    if((x < 15) || (x > width - 15) || (y < radius) || (y > height - radius) )
      return true;
    else
      return false;
  }  
  boolean isBugInWall(int [][]level, int tileSize){

    topLeft.x = (int) x / tileSize;
    topLeft.y = (int) y / tileSize;
    
    bottomRight.x = (int) (x + radius) / tileSize;
    bottomRight.y = (int) (y + radius) / tileSize;
    
    topRight.x = (int) (x + radius) / tileSize;
    topRight.y = (int) y / tileSize;
    
    bottomLeft.x = (int) x / tileSize;
    bottomLeft.y = (int) (y + radius) / tileSize;
    
    if((level[(int)topLeft.x][(int)topLeft.y] == 12) || (level[(int)topRight.x][(int)topRight.y] == 12))          //12 is wall id
      return true;  
    else if  ((level[(int)bottomRight.x][(int)bottomRight.y] == 12)|| (level[(int)bottomLeft.x][(int)bottomLeft.y] == 12) )
      return true;
    else
      return false;
  }

}
