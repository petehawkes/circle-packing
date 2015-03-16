

ArrayList allCircles;

int circleCount = 1;
int circleCounter = 0;
int padding = 100;

int circleTrans = 20;

int errorCount = 1;
int errorMax = 20;

float timeStamp;

void setup() {

  size(1200, 675);
  smooth();
  noStroke();

  allCircles = new ArrayList();

  addMoreCircles();
}




void draw() {

  background(0);

  for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    c.update();
    c.display();
  }

  collisionCheck();
  //connectCircles();
  
  if (errorMax < 800 && millis() - timeStamp > 250) {
    addMoreCircles();
    timeStamp = millis();
      
  }
  
  
  
}

void collisionCheck() {

  for (int i=0; i<allCircles.size(); i++) {

    Circle c1 = (Circle) allCircles.get(i);

    for (int j=i+1; j<allCircles.size(); j++) {

      Circle c2 = (Circle) allCircles.get(j);
      float d = c1.pos.dist(c2.pos);
      if (d < c1.currentRad + c2.currentRad + 1) {
        c1.hit = true;
        c2.hit = true;
      }
    }
  }
}


boolean checkHit(PVector newPos) {
  
  boolean hit = false;
  
  for (int i=0; i<allCircles.size(); i++) {
    
    Circle c = (Circle) allCircles.get(i);
    float d = c.pos.dist(newPos);
    if (d < c.currentRad+2) {
      return true;
    }
    
  }
  errorCount = 0;
  return false;

}


void addMoreCircles() {
   for (int i=0; i<circleCount; i++) {
    float _x = random(-padding, width+padding);
    float _y = random(-padding, height+padding);
    PVector newPos = new PVector(_x, _y);
    
    if (!checkHit(newPos)) { 
        circleCounter++;
        allCircles.add(new Circle(newPos, circleTrans));
    } else {
        errorCount++;
        println("error:" + errorCount + "/" + errorMax);
    }
  }
  
   
  if (errorMax < 400) {
    circleCount+=1;
    errorMax += 10;
  } else {
    circleCount+=40;
    errorMax += 15;
  }
  circleTrans += 3;
  
  
}




void mousePressed() {
    //addMoreCircles();
}




