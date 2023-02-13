ArrayList <Bug> bugs = new ArrayList();
int amount = 20;

boolean [] keys;
float playerSpeed = 1.5;
Player player;
Laser laser;

void setup(){
  size(600,600); 
  frameRate(60);
  for(int i = 0; i < amount; ++i){
     bugs.add(new Bug());
  }
  player = new Player();
  laser = new Laser(-100, -100);
  
  keys = new boolean[128];
  
}

void draw(){
  background(20,64,74); // (148,177,156)
  
  for(int i = 0 ; i < amount; ++i){
    float dist = sqrt((bugs.get(i).x - laser.x) * (bugs.get(i).x - laser.x) + (bugs.get(i).y - laser.y) * (bugs.get(i).y - laser.y));
    if(dist <= laser.radius){
      bugs.remove(i);
      amount--;
      
    }
  }
  
  for(int i = 0; i < amount; ++i){
     bugs.get(i).drawBug();
  }
  
  move();
  player.drawPlayer();
  if(player.cooldown <= 240)
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
    laser = new Laser(player.x, player.y);
  }
    
    player.updatePlayer(xDelta, yDelta);
}

void keyPressed(){
  keys[key] = true;
}
void keyReleased(){
  keys[key] = false;
}
