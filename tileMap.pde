PImage tiles;
PImage [] map;
int rows = 28;
int cols = 10;
int tileSize = 16;
int tileNum = 0;
boolean mapEditor = false;
int windowSize = 500;

int levelSize = windowSize / tileSize;//level size in tiles

int firstLevel[][];

void setup(){
  size(500,500);
  frameRate(60);
  
  tiles = loadImage("tilesBLANK.png");
  setupTiles();  //to cut image into 16x16 tiles
  firstLevel = new int [levelSize][levelSize];
}

void draw(){
  background(148,177,156);
   drawMap();
  if(mapEditor){
    showMapEditor();    
  }

  
}


void setupTiles(){
  PImage temp;
  map = new PImage[rows * cols];
  for(int i = 0; i < rows; ++i){
    for(int j = 0; j < cols; ++j){
      temp = tiles.get(tileSize * j, tileSize * i,tileSize,tileSize);
      map[ i * cols + j] = temp;
    }
  }
}


void showMapEditor(){
  //fill(148,177,156);
  noFill();
  stroke(109,130,115);
  for(int i = 0; i < windowSize; ++i){
    for(int j = 0; j < windowSize; ++j){
      rect(i * tileSize, j * tileSize, tileSize, tileSize);
    }
  }
  
  image(tiles,0,0);
  int mousePositionX, mousePositionY;
  
  if(mouseX < tiles.width && mouseY < tiles.height && mousePressed ){
    mousePositionX = int(mouseX / tileSize); 
    mousePositionY = int(mouseY / tileSize);
    tileNum = mousePositionY * cols + mousePositionX;
  }
  
  image(map[tileNum], mouseX,mouseY, 50,50);
  
  if(mousePressed && (mouseX > tiles.width || mouseY > tiles.height)){ // pakeisti!
    //if(mouseX < )
    int tempX = int(mouseX / tileSize); 
    int tempY = int(mouseY / tileSize);
    firstLevel[tempX][tempY] = tileNum; 
    
  }
}

void keyPressed(){
 if(key == 'e') 
   mapEditor = !mapEditor; 
  
}
void drawMap(){
  for(int i = 0; i < levelSize; ++i){
    for(int j = 0; j < levelSize; ++j){
      image(map[firstLevel[i][j]],i * tileSize,j * tileSize);  
    }
  }
  
}
