class Map{
  PImage tiles;
  PImage [] map;        //array for cuted tiles
  int rows = 28;        //size of tile image in tales
  int cols = 10;        //size of tile image in tales
  int tileSize = 16;
  int tileNum = 0;      //which tile is curently selected (is used in editor mode)
  
  boolean mapEditor = false;
  boolean editorIsVisible = true;
  int windowSize = 500;
  
  int levelSize = 1000 / tileSize;                  //level size in tiles
  
  int firstLevel[][];                               //first level "map" with tile's id's 
  Table table;                                      //table object to upload data from csv file
  
  //constructor
  Map(){            
    firstLevel = new int [levelSize][levelSize];
    tiles = loadImage("tilesBLANK.png");            //"tilesBLANK.png" png with tiles
    
    setupTiles();  //cut image into 16x16 tiles
   
    table = loadTable("firstTry.csv");             //copy data from csv file to a 2d array
    for(int i = 0; i < table.getRowCount(); ++i){
      for(int j = 0; j <table.getRowCount(); ++j ){
        firstLevel[j][i] = table.getInt(i,j);
      }
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
 //methods
 void showMapEditor(){
    noFill();
    stroke(109,130,115);
    for(int i = 0; i < windowSize; ++i){
      for(int j = 0; j < windowSize; ++j){
        rect(i * tileSize, j * tileSize, tileSize, tileSize);
      }
    }
    if(editorIsVisible)
      image(tiles,0,0);
    int mousePositionX, mousePositionY;
    
    if(mouseX < tiles.width && mouseY < tiles.height && mousePressed && editorIsVisible ){
      mousePositionX = int(mouseX / tileSize); 
      mousePositionY = int(mouseY / tileSize);
      tileNum = mousePositionY * cols + mousePositionX;
    }
    
    image(map[tileNum], mouseX,mouseY, 50,50);
    
    if(mousePressed && (mouseX > tiles.width || mouseY > tiles.height)){ // pakeisti!
      //if(mouseX < )
      int tempX = int(mouseX / tileSize);  // pakeisti!
      int tempY = int(mouseY / tileSize);
      firstLevel[tempX][tempY] = tileNum;    
    }
    if(mousePressed  && !editorIsVisible){
      int tempX = int(mouseX / tileSize); 
      int tempY = int(mouseY / tileSize);
      firstLevel[tempX][tempY] = tileNum;    
    }
  }
  void drawMap(int [][] level){
    for(int i = 0; i < windowSize / tileSize; ++i){
      for(int j = 0; j < windowSize / tileSize; ++j){
        image(map[level[i][j]],i * tileSize,j * tileSize);  
      }
    }
  }

}
