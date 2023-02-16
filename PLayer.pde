
class Player{
  float x,y;
  PImage playerSpriteSheet, gunSpriteSheet;
  PImage [][] movement;
  PImage [][] gun;
  boolean inMotion, hasGun;
  int curDirection;
  float curFrame;
  PVector topLeft, topRight, bottomLeft, bottomRight;  //player's corner coords
  
  
  int charHeight = 26;
  int charWidth = 16;
  
  final int UP = 2, LEFT = 3, DOWN = 1, RIGHT = 0;  //sprireSheet row
  
  Player(){
    topLeft = new PVector();
    topRight = new PVector();
    bottomLeft = new PVector();
    bottomRight = new PVector();
    
    inMotion = false;
    hasGun = true;
    curDirection = 1;
    curFrame = 0;
    
    
    x = 100;
    y = 80;
    
    setupSprites();
  }
  void setupSprites(){
    movement = new PImage[4][4];
    gun = new PImage[4][4];
    playerSpriteSheet = loadImage("dudeWutIsScratch.png");
    gunSpriteSheet = loadImage("dudeWutIsScratchGUN.png");
    
    for(int i = 0; i < 4; ++i){
      for(int j = 0; j < 4; ++j){
        movement[j][i] = playerSpriteSheet.get(8 + (32 * j),3 + (32 * i),charWidth,charHeight);                  // x,y, how much to cut from x, how much to cut from y
        gun[j][i] = gunSpriteSheet.get(8 + (32 * j),3 + (32 * i),charWidth,charHeight); 
      } 
    }
    
  }
  
  void drawPlayer(){
     if(inMotion && hasGun)
       image(gun[curDirection][1 + (int)curFrame], x,y);  
     else if(inMotion && !hasGun)
       image(movement[curDirection][1 + (int)curFrame], x,y);
     else if(!inMotion && hasGun)
       image(gun[curDirection][0], x,y);
     else
       image(movement[curDirection][0], x,y);  
  } 
  
  void updatePlayer(int xDelta, int yDelta, int [][] level,int tileSize){
    inMotion = true;
    curFrame = (curFrame + 0.2) % 3;    //0.2 we can change %3 3 - number of diffrent frames 
    
    if(xDelta == 0 && yDelta == 0)
      inMotion = false;
    else if(xDelta == -playerSpeed)
      curDirection = LEFT;
    else if(xDelta == playerSpeed)
      curDirection = RIGHT;
    else if(yDelta == -playerSpeed)
      curDirection = UP;
    else if(yDelta == playerSpeed)
      curDirection = DOWN; 
    
    x += xDelta;
    y += yDelta;
    if(isPlayerOffScreen(x,y) || isPlayerInWals(x, y, level, tileSize) ){
      x -= xDelta;
      y -= yDelta;
    }
  }
  
  boolean isPlayerOffScreen(float x, float y){
  if(x < 16 || x > width - 16 || y < 26 || y > height - 26)    
    return true;
  else
    return false;
  }
  
  boolean isPlayerInWals(float x,float y,int [][] level, int tileSize){
    
    topLeft.x = (int) x / tileSize;
    topLeft.y = (int) y / tileSize;
    
    bottomRight.x = (int) (x + charWidth) / tileSize;
    bottomRight.y = (int) (y + charHeight) / tileSize;
    
    topRight.x = (int) (x + charWidth) / tileSize;
    topRight.y = (int) y / tileSize;
    
    bottomLeft.x = (int) x / tileSize;
    bottomLeft.y = (int) (y + charHeight) / tileSize;
    
    if((level[(int)topLeft.x][(int)topLeft.y] == 12) || (level[(int)topRight.x][(int)topRight.y] == 12))          //12 is wall id
      return true;  
    else if  ((level[(int)bottomRight.x][(int)bottomRight.y] == 12)|| (level[(int)bottomLeft.x][(int)bottomLeft.y] == 12) )
      return true;
    else
      return false;
  }
}
