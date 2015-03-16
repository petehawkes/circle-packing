

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

PVector mid;

Boolean endAll = false;


//boolean attemptingNewRadial = false;

void setup() {

  size(800, 600, OPENGL);
  smooth();
  noStroke();

  allCircles = new ArrayList();


  mid = new PVector(0, 0); 
 

  addCircle(mid, 50);
  activeCircle = (Circle) allCircles.get(activeIndex);
  
 
}




void draw() {

  background(0);


  //currentScalar += (scalar - currentScalar) * .3;
  

  pushMatrix();
  translate(width/2, height/2);
  //scale(currentScalar, currentScalar);
   for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    
    if (c.rad * scalar < 1) c.killMe = true;
    
    c.update();
    c.display();
    
  }
  //connectCircles();
  popMatrix();
  
  
 
  
  if (!endAll) {
  errorCount = 0;
  newRadial(activeCircle.pos, activeCircle.rad); 
  }
 // }
  
  
  
}



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
   //float dis = (300 - mid.dist(origin))/300;
   float dis = 1;
   float newRad = random(originRad, originRad+ 50*dis);
  
   float newX = origin.x + (cos(radian)*newRad);
   float newY = origin.y + (sin(radian)*newRad);
  
   PVector newOrigin = new PVector(newX, newY);
   
 
   while(checkHit(newOrigin, newRad-originRad) && newRad > originRad) {
       newRad -= 2; 
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
   if (activeIndex < allCircles.size()) {
     activeCircle = (Circle) allCircles.get(activeIndex);
   } else {
      endAll = true; 
      //println("ENDED"); 
      printData();
   }
   if (activeCircle.rad < 5 && !endAll) {
      nextCircle(); 
   }
   
   //println(activeIndex +"/"+allCircles.size());

}


void addCircle(PVector newPos, float rad) {
  //if (allCircles.size() < 6) {
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
 /* } else {
    endAll = true;
    printData();
  }*/
}

void updateScalar(float s) {
   //if (s < scalar) scalar = s; 
}



void printData() {
  println("// this is the data");
  println("");
  // print xpos
  print("float $x_pos[] = {");
  for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    print(c.pos.x); 
    if (i < allCircles.size()-1) print(", ");
  }
 println("};");
 println("");
  // print ypos
  print("float $y_pos[] = {");
  for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    print(c.pos.y); 
    if (i < allCircles.size()-1) print(", ");
  }
 println("};");
 println("");
  // print rads
  print("float $all_rads[] = {");
  for (int i=0; i<allCircles.size(); i++) {
    Circle c = (Circle) allCircles.get(i);
    print(c.rad); 
    if (i < allCircles.size()-1) print(", ");
  }
 println("};");
 println("");
 // print mel script
 println("");
 println("// this is the script");
 println("int $size = size($x_pos);");
 println("for($i=0;$i<$size;++$i) {");
 println("   polySphere -r $all_rads[$i] -sx 50 -sy 50 -ax 0 1 0 -cuv 2 -ch 1;");
 println("   move -r $x_pos[$i] 0 $y_pos[$i];");
 println("}");
 // $value = $int_array[ $i ];
 
}

void mousePressed() {
   endAll = true; 
   printData();
}




