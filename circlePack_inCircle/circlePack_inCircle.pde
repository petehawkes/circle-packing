

ArrayList allCircles;
float bound;
float timeStamp = 0;

void setup() {

  size(800, 600);
  smooth();
  noStroke();

  bound = 150;
  allCircles = new ArrayList();
}


void draw() {

  background(50);

  pushMatrix();
  translate(width/2, height/2);

  for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    c.update();
    c.display();
  }

  for (int i=0; i<allCircles.size(); i++) { 
    Circle c = (Circle) allCircles.get(i); 
    if (c.killMe) allCircles.remove(i);
  }

  noFill();
  stroke(100);
  strokeWeight(1);
  ellipse(0, 0, bound*2, bound*2);

  popMatrix();
}


void addCircle(PVector newPos, float rad) {
  allCircles.add(new Circle(newPos, rad));
}

void mouseMoved() {
  if (millis() - timeStamp > 10) {
    PVector p = new PVector (mouseX - width/2, mouseY - height/2);
    addCircle(p, random(50, 100));
    timeStamp = millis();
  }
}

