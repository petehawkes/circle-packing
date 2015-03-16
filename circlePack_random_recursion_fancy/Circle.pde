class Circle {
  
  PVector pos;
  float rad;
  float currentRad;
  float currentAlpha;
  color clr;
  String name;
  

  Circle (float _x, float _y, float _rad, String _name ) {
    pos = new PVector(_x, _y);
    rad = _rad; 
    clr = color(255);
    name = _name;
    currentRad = 1;
    currentAlpha = 255;
  }
  
  void display() {
     
     pushMatrix();
     translate(pos.x, pos.y);
     noStroke();
     fill(clr, currentAlpha);
     ellipse(0, 0, currentRad*2, currentRad*2); 
     popMatrix();
    
  }
  
  void update() {
    if (abs(currentRad - rad) > .1) {  
      currentRad += (rad - currentRad) * .1;
    }
    if (currentAlpha > 10 + map(currentRad, 1, 150, 20, 0)) currentAlpha -= 5;
  } 
  
};
  
  
