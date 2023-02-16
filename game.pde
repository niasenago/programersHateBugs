
/*
*  'w' 'a' 's' 'd' keys are to move main character
*  'c' to "dwop the flashlight" and move faster
*  'p' to open editor, 'o' to temporalily close tiles
*  ' ' to use flashlight
*/


ArrayList <Bug> bugs = new ArrayList();
int amount = 3;

Map map;

boolean [] keys;
float playerSpeed = 1.5;
Player player;
Laser laser;

void setup(){
  size(450,450); 
  frameRate(60);
  
  map = new Map();
  
  for(int i = 0; i < amount; ++i){
     bugs.add(new Bug());
  }
  
  player = new Player();
  laser = new Laser(-100, -100,player.charWidth,  player.charHeight);
  
  keys = new boolean[128];
  
}

void draw(){
  background (148,177,156); // (20,64,74); //
  
  map.drawMap(map.firstLevel);
  

  
  for(int i = 0 ; i < amount; ++i){
    float dist = sqrt((bugs.get(i).x - laser.x) * (bugs.get(i).x - laser.x) + (bugs.get(i).y - laser.y) * (bugs.get(i).y - laser.y));
    if(dist <= laser.radius){
      bugs.remove(i);
      amount--;   
    }
  }
  
  for(int i = 0; i < amount; ++i)
     bugs.get(i).drawBug(map.firstLevel, map.tileSize);
  
  if(map.mapEditor)
    map.showMapEditor();    
  
  move();
  
  player.drawPlayer();
  
  laser.drawLaser();
} 

void move(){
  
  int xDelta = 0, yDelta = 0;
  if(!player.hasGun){
    playerSpeed = 3;
  }else
    playerSpeed = 1;
    
  if(keys['w'])
    yDelta -= playerSpeed;
  if(keys['a'])
    xDelta -= playerSpeed;
  if(keys['s'])
    yDelta += playerSpeed;
  if(keys['d'])
    xDelta += playerSpeed; 
    
  if(keys['c']){
    player.hasGun = !player.hasGun;
    //println("changed");
  }
    
  if(keys[' ']){
    if(player.hasGun)
    laser = new Laser(player.x, player.y,player.charWidth,  player.charHeight );
  }
    
    player.updatePlayer(xDelta, yDelta, map.firstLevel, map.tileSize);
}

void keyPressed(){
  keys[key] = true;
  
  if(key == 'p') 
    map.mapEditor = !map.mapEditor; 
  if(key == 'o')
    map.editorIsVisible = !map.editorIsVisible;
}

void keyReleased(){
  keys[key] = false;
}
