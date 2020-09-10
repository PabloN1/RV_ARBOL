Arbol arbol;

float rX, rY, velocityX, velocityY = 0;
float AnguloVista = 0;
float distancia = 20;
float verdeomarron=0;

float lengthRatio = 1.0;
float angleSplit = PI/3;
float splits = 5.0;
int ProfundidadRama = 3;

int IniT = 0;
float FinT = 0;

void setup(){
  size(1000,1000,P3D);
  rectMode(CENTER);
  
  arbol = new Arbol(0,0,0,0,0,0,10,30,0);
}

void draw(){
  IniT = millis();
    
  background(50);
  rX += velocityX;
  rY += velocityY;
  velocityX *= 0.95;
  velocityY *= 0.95;  
  
  
  translate(width/2,height*0.9);
  rotateX(radians(-TWO_PI-rX));
  rotateY(radians(-rY));  
  scale(4);
  rotateY(AnguloVista);
  
  arbol.Dibuja();

  
  AnguloVista += 0.00005 * FinT;
  
  FinT = millis() - IniT;
  
   if(mousePressed){
    velocityX += (mouseY-pmouseY) * 0.05;
    velocityY -= (mouseX-pmouseX) * 0.05;
  }
}

void keyPressed(){
  if(key == CODED){
    
    switch(keyCode){
      case UP:
        splits++;
        if(splits > 5){
           splits = 5;
        }
        arbol = new Arbol(0,0,0,0,0,0,10,30,0);
        break;
      case DOWN:
        splits--;
        if(splits < 1){
           splits = 1;
        }
        arbol = new Arbol(0,0,0,0,0,0,10,30,0);
        break;
      case LEFT:
         angleSplit-= 0.05;
         if(angleSplit < -PI/2){
           angleSplit = -PI/2;
         }
         arbol.updateAngulo(0,0,0);
        break;
      case RIGHT:
        angleSplit+= 0.05;
         if(angleSplit > PI/2){
           angleSplit = PI/2;
         }
         arbol.updateAngulo(0,0,0);
        break;
   
    }
   
  }
  else{
    switch(key){
      case '1':
         ProfundidadRama = 0;
         break;
      case '2':
         ProfundidadRama = 1;
          break;
      case '3':
         ProfundidadRama = 2;
          break;
      case '4':
         ProfundidadRama = 3;
          break;
      case '5':
         ProfundidadRama = 4;
          break;
      case '6':
         ProfundidadRama = 5;
         break;
    }
    
    arbol = new Arbol(0,0,0,0,0,0,10,30,0);
  }

}
