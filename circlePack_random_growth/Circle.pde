class Circle {
  
  PVector pos;
  float currentRad;
  float growthRate;
  float currentAlpha;
  color clr;
  String name;
  boolean hit;
  

  Circle (PVector _pos, int circleTrans ) {
    pos = _pos;
    clr = color(255);
    currentRad = random(-30, 0);
    currentAlpha = circleTrans;
    growthRate = 1;
    hit = false;
  }
  
  void display() {
      
     float rad; 
    
     if (currentRad < 0) {
         rad = 0;
     } else {
        rad = currentRad; 
     }
    
     pushMatrix();
     translate(pos.x, pos.y);
     noStroke();
     fill( currentAlpha);
     ellipse(0, 0, rad*2, rad*2); 
     popMatrix();
    
  }
  
  void update() {
    if (!hit) grow();
  } 
  
  
  void grow() {
    currentRad += growthRate;
  }
  
};
  
  
