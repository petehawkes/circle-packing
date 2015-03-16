

ArrayList allCircles;

int circleCount = 1;
int circleCounter = 0;
int padding = 100;

int circleTrans = 20;
int errorCount = 1;
int errorMax = 0;

float timeStamp;

Circle activeCircle;
int activeIndex = 0;

float expandSize = 200;

float scalar = 1;
float currentScalar = 1;

boolean drawing = true;



//boolean attemptingNewRadial = false;

void setup() {

  size(1440, 900, OPENGL);
  smooth();
  noStroke();

  allCircles = new ArrayList();


  PVector p = new PVector(0, 0); 

  addCircle(p, 100);
  activeCircle = (Circle) allCircles.get(activeIndex);
  
 
}




void draw() {

  background(0);

  if (drawing) {
    currentScalar += (scalar - currentScalar) * .3;
  } else {
    currentScalar *= 1.3; 
  }


  pushMatrix();
  translate(width/2, height/2);
  scale(currentScalar, currentScalar);
   for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    
    if (c.rad * scalar < 1) c.killMe = true;
    
    c.update();
    c.display();
    
  }
  if (drawing) connectCircles();
  popMatrix();
  
  
 
  
  errorCount = 0;
  if (drawing) newRadial(activeCircle.pos, activeCircle.rad); 
 // }
  
  
  
}


/*
void killDeadCircles() {
 for (int i=allCircles.size()-1; i>=0; i--) {
    Circle c = (Circle) allCircles.get(i);
   
    if (c.killMe) allCircles.remove(i);
  
  } 
}
*/

boolean checkHit(PVector newPos, float rad) {
  
  boolean hit = false;
  
  // limit the hit check to improve performance (this creates overlapping)
  //int checkStart = allCircles.size() - 200;
  //if (checkStart < 0) checkStart = 0;
  
  for (int i=0; i<allCircles.size(); i++) {
    
    Circle c = (Circle) allCircles.get(i);
    float d = c.pos.dist(newPos);
    if (d < c.rad + rad) {
      return true;
    }
    
  }
 
  return false;

}

void newRadial(PVector origin, float originRad) {
  
   //attemptingNewRadial = true;
  
   float radian = random(0, TWO_PI);
   float newRad = random(originRad+(1/scalar), originRad+expandSize);
  
   float newX = origin.x + (cos(radian)*newRad);
   float newY = origin.y + (sin(radian)*newRad);
  
   PVector newOrigin = new PVector(newX, newY);
   
 
   while(checkHit(newOrigin, newRad-originRad) && newRad > originRad+(1/scalar)) {
       newRad -=   3 * (1/scalar); 
       newOrigin.x = origin.x + (cos(radian)*newRad);
       newOrigin.y = origin.y + (sin(radian)*newRad);
   }
   
   
   
   if (!checkHit(newOrigin, newRad-originRad)) {
       addCircle(newOrigin, newRad-originRad);
       errorCount = 0;
   } else {
       errorCount++;
       //println("error:"+errorCount+"/"+errorMax);
       if (errorCount < errorMax) {
         newRadial(origin, originRad); 
       } else {
         //attemptingNewRadial = false;
         nextCircle();
       }
   }
   
  
  
}

void nextCircle() {
    
  
   activeCircle.currentAlpha = 20;
   activeIndex++;
   if( activeIndex >= allCircles.size() ){ activeIndex = 0; }
   activeCircle = (Circle) allCircles.get(activeIndex);
   
   if (activeCircle.rad * scalar < 10) {
      nextCircle(); 
   }
   
   println(activeIndex +"/"+allCircles.size());

}


void addCircle(PVector newPos, float rad) {
    allCircles.add(new Circle(newPos, rad));
    
    float s; 
    if (abs(newPos.y) + rad > height/2) {
       s = (height/2)/(abs(newPos.y) + rad);
       updateScalar(s);
    }
     if (abs(newPos.x) + rad > width/2) {
       s = (width/2)/(abs(newPos.x) + rad);
       updateScalar(s);
    }
}

void updateScalar(float s) {
   if (s < scalar) scalar = s;
   expandSize = 100/scalar; 
}


void connectCircles() {
  
  int lineMax = 20;
  
  if (allCircles.size() > lineMax) {
    for (int i=allCircles.size()-lineMax; i<allCircles.size()-2; i++) {
      
       Circle c1 = (Circle) allCircles.get(i);
       Circle c2 = (Circle) allCircles.get(i+1);
       Circle c3 = (Circle) allCircles.get(i+2);
      
       float a = (allCircles.size() - i)*5;
       stroke(255, a);
       fill(140, 200, 60, a/2);
       
       println();
       beginShape();
         vertex(c1.pos.x, c1.pos.y);
         vertex(c2.pos.x, c2.pos.y);
         vertex(c3.pos.x, c3.pos.y);
       endShape();
    }
  }
 
}



void mousePressed() {
    drawing = false;
}

void mouseReleased() {
  drawing = true;
}




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
     ellipse(0, 0, r*2, r*2); 
     popMatrix();
    
  }
  
  void update() {
    currentRad += (rad - currentRad) * .3;
  } 
  
 
  
};
  
  

