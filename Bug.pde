class Bug{
  //members - variables of th object(attributes)
  float x, y;
  PVector speed;
  PImage img;
  
  //constructor - initializes the variables or settings of the object(sets up those attributes)
  Bug(){
    img = loadImage("beetleDARK.png");
    
    x = random(10, width - 10);
    y = random(10, height - 10);
    
    speed = new PVector(random(-1,1), random(-1,1));
  }
  
  //method - functions in the object that the class creates(abilities of the object)
  void drawBug(){
    moveBug();
    
    pushMatrix();
    translate(x + img.width / 2, y + img.height / 2);  //lesson 20
    rotate(speed.heading()+ PI/2);  // in radians 0;2pi
    translate(-img.width / 2, - img.height / 2 );
    
    image(img,0,0);
    
    popMatrix();
  }

  void moveBug(){
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
      
      if(isBugOffScreen() == true){
        x -= speed.x;
        y -= speed.y;
        speed.rotate(random(-2,2));
      }
  }
  
  boolean isBugOffScreen(){
    int radius = 30;
    if((x < 15) || (x > width - 15) || (y < radius) || (y > height - radius) )
      return true;
    else
      return false;
  }  

}
