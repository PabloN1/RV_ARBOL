class Arbol{
  
  Arbol[] ArbolSig;

  PVector[] puntos = new PVector[8];
 
  float base = 10;
  float techo;
  float altura = 30;
  
  PVector startP;
  PVector endP;
  
  PVector xyzAngles;

  
  int profundidad;
  
  Arbol(float X, float Y, float Z, float AX, float AY, float AZ, float B, float alt, int prof){
 
    xyzAngles = new PVector(AX,AY,AZ);
    profundidad = prof;
    startP = new PVector(X, Y, Z);
    endP = new PVector(X, Y - alt, Z);
    base = B;
    techo = base / 2;
    altura = alt;
    
    puntos[0] = new PVector(-base/2.0, 0,  base/2.0);
    puntos[1] = new PVector( base/2.0, 0,  base/2.0);
    puntos[2] = new PVector( base/2.0, 0, -base/2.0);
    puntos[3] = new PVector(-base/2.0, 0, -base/2.0);
    puntos[4] = new PVector(-techo/2.0, -altura,  techo/2.0);
    puntos[5] = new PVector( techo/2.0, -altura,  techo/2.0);
    puntos[6] = new PVector( techo/2.0, -altura, -techo/2.0);
    puntos[7] = new PVector(-techo/2.0, -altura, -techo/2.0);
    
    if(profundidad < ProfundidadRama){
      ArbolSig = new Arbol[(int)splits];
      for(int i = 0; i < splits; i++){
        float angleShift = i * ((2*PI) / splits);
        float angleRot = (2*PI) / (splits * 2);
             
        ArbolSig[i] = new Arbol(endP.x,endP.y,endP.z,angleSplit,angleRot,xyzAngles.z + angleShift,techo,altura*lengthRatio,profundidad+1);
      }
    }
  }
  
  void updateAngulo(float AX, float AY, float AZ){
    
    xyzAngles = new PVector(AX,AY,AZ);
    
    if(profundidad < ProfundidadRama){
      for(int i = 0; i < splits; i++){
        float angleShift = i * ((2*PI) / splits);
        float angleRot = (2*PI) / (splits * 2);
        ArbolSig[i].updateAngulo(angleSplit,angleRot,xyzAngles.z + angleShift);
      }
    }
  }
  
  void Dibuja(){    
    fill(lerpColor(#009C22,#8b4513,ProfundidadRama/(profundidad+2)));
    translate(startP.x,startP.y,startP.z);
    
    rotateZ(xyzAngles.z); 
    rotateX(xyzAngles.x);
    
    
    // base
    beginShape();
    vertex(puntos[0].x,puntos[0].y,puntos[0].z);
    vertex(puntos[1].x,puntos[1].y,puntos[1].z);
    vertex(puntos[2].x,puntos[2].y,puntos[2].z);
    vertex(puntos[3].x,puntos[3].y,puntos[3].z);
    endShape(CLOSE);
    
    
    // techo
    beginShape();
    vertex(puntos[4].x,puntos[4].y,puntos[4].z);
    vertex(puntos[5].x,puntos[5].y,puntos[5].z);
    vertex(puntos[6].x,puntos[6].y,puntos[6].z);
    vertex(puntos[7].x,puntos[7].y,puntos[7].z);
    endShape(CLOSE);

    for(int i = 0; i < 4; i++){
      rotateY((2*PI)/4);
      //los lados         
      beginShape();
      vertex(puntos[0].x,puntos[0].y,puntos[0].z);
      vertex(puntos[4].x,puntos[4].y,puntos[4].z);
      vertex(puntos[7].x,puntos[7].y,puntos[7].z);
      vertex(puntos[3].x,puntos[3].y,puntos[3].z);
      endShape(CLOSE);
    }
    
    
   
    rotateY(xyzAngles.y);
    translate(0,-altura,-altura * (profundidad+1));
    
    rotateX(-PI/2); 
   
   
    if(profundidad < ProfundidadRama){
      
      for(int i = 0; i < ArbolSig.length; i++){
        if(ArbolSig[i] != null){
          ArbolSig[i].Dibuja();
        }
      }
    }
        
    rotateX(PI/2);
    
    translate(0,altura,altura* (profundidad+1));
    
    rotateY(-xyzAngles.y);
    
    rotateX(-xyzAngles.x);
    rotateZ(-xyzAngles.z);
     
    translate(-startP.x,-startP.y,-startP.z);
    
  }}
