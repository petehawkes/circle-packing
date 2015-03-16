

ArrayList allCircles;

int circleCount = 0;
float currentRad = 150;

int errorCount = 0;
int errorMax = 1;
boolean makingCircles = true;

void setup() {
  
  size(1200, 675);
  smooth();
  noStroke();
  
  allCircles = new ArrayList();
  //allCircles.add(new Circle(200, 200, 100, "test"));
  //newCircle();
  
}




void draw() {
  
  background(0);
  
  if (makingCircles) {
    newCircle();
  }
  
  for (int i=0; i<allCircles.size(); i++) {
     Circle c = (Circle) allCircles.get(i);
     c.update();
     c.display(); 
  }
  //connectCircles();
  
  
}

boolean checkHit(PVector newPos, float rad) {
  
  boolean hit = false;
  
  for (int i=0; i<allCircles.size(); i++) {
    
    Circle c = (Circle) allCircles.get(i);
    float d = c.pos.dist(newPos);
    if (d < c.rad + rad) {
      
      errorCount++;
      println("error:" + errorCount + "/" + errorMax);
      return true;
    }
    
  }
  errorCount = 0;
  return false;

}

void connectCircles() {
  
  
  
  int lineMax = 10;
  
  if (allCircles.size() > lineMax) {
    for (int i=allCircles.size()-lineMax; i<allCircles.size()-2; i++) {
      
       Circle c1 = (Circle) allCircles.get(i);
       Circle c2 = (Circle) allCircles.get(i+1);
       Circle c3 = (Circle) allCircles.get(i+2);
      
       float a = (allCircles.size() - i)*5;
       stroke(255, a);
       fill(0, 175, 240, a/2);
       
       println();
       beginShape();
         vertex(c1.pos.x, c1.pos.y);
         vertex(c2.pos.x, c2.pos.y);
         vertex(c3.pos.x, c3.pos.y);
       endShape();
    }
  }
 
  
  
}


void newCircle() {
  
  circleCount++;
  
  int padding = 100;
  
  float _x = random(-padding, width+padding);
  float _y = random(-padding, height+padding);
  
  PVector newPos = new PVector(_x, _y);
  
  //
  // If the new position doesn't hit anything, make a new circle
  if (!checkHit(newPos, currentRad)) {
     allCircles.add(new Circle(newPos.x, newPos.y, currentRad, "circle"+circleCount));
  } else {
     // otherwise check to see how many hits have occurred since the last successful placement
     if (errorCount > errorMax) {
       // if we've reached the max, decrease circle size
       // also allow for more errors for tighter packing (warning, runs the risk of crashing if this gets too high)
       currentRad *= .8;
       errorMax += 5;
     } 
     //
     // if the circle size isn't too small, try again
     // otherwise, stop trying
     if (currentRad > 1 ) {
       newCircle();
     } else {
       makingCircles = false;
       println("finished"); 
     }
  }
  
}





