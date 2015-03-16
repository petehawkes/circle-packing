class Circle {

  PVector pos;
  PVector dest;
  float radTarg;
  float rad;
  color clr;
  String name;
  float strokeWidth;


  boolean init = false;
  boolean dying, killMe = false;

  Circle (PVector _pos, float _rad ) {
    pos = dest = _pos;
    radTarg = _rad;
    clr = color(255);
    rad = 0;
    strokeWidth = 10;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255);
    noStroke();
    ellipse(0, 0, rad*2, rad*2);
    popMatrix();
  }

  void update() {
    if (!init) grow();
    gravity();
    pos.x += (dest.x - pos.x) *.1;
    pos.y += (dest.y - pos.y) *.1;
    checkDeath();
  } 

  void gravity() {

    float dist, max;
    for (int i=0; i<allCircles.size(); i++) {
      Circle c = (Circle) allCircles.get(i);
      if (c != this) {
        dist = dist(c.pos.x, c.pos.y, pos.x, pos.y);
        if (dist < .1) {
          // fix 0 distance bug
          c.pos.x += random(-10, 10);
          c.pos.y += random(-10, 10);
          pos.x += random(-10, 10);
          pos.y += random(-10, 10); 
          dist = dist(c.pos.x, c.pos.y, pos.x, pos.y);
        }
        max = c.rad + rad;
        if (dist < max) {
          moveMe(PVector.sub(pos, c.pos), max/dist*3);
        } 
        println(dist);
      }
    }
  }

  void moveMe( PVector p, float mod ) {
    p.normalize();
    dest.x += p.x * mod;
    dest.y += p.y * mod;
  }

  void checkDeath() {
    if (!dying) {
      if (pos.mag() > bound) {
        dying = true;
      }
    } 
    else {
      rad *= .8;
      if (rad < 1) {
        killMe = true;
      }
    }
  }

  void grow() {
    if (!dying) {
      rad += (radTarg - rad) * .3;
      if (radTarg - rad < .1) {
        rad = radTarg;
        init = true;
      }
    }
  }
};

