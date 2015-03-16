class Circle {
  
  PVector pos;
  float rad;
  float currentRad;
  float growthRate;
  float currentAlpha;
  color clr;
  String name;
  boolean hit;
  boolean killMe;
  

  Circle (PVector _pos, float _rad ) {
    pos = _pos;
    rad = _rad;
    clr = color(255);
    currentRad = random(-30, 0);
    currentAlpha = random(20, 80);
    growthRate = 1;
    hit = false;
    killMe = false;
  }
  
  void display() {
      
     float r; 
    
     if (currentRad < 0) {
         r = 0;
     } else {
        r = currentRad; 
     }
    
     pushMatrix();
     translate(pos.x, pos.y);
     noStroke();
     fill(255, currentAlpha);
     ellipse(0, 0, r*1.8, r*1.8); 
     popMatrix();
    
  }
  
  void update() {
    currentRad += (rad - currentRad) * .3;
  } 
  
 
  
};
  
  
