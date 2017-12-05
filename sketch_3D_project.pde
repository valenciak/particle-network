ArrayList<Particle> pList;
PVector pv;
int distance = 10;
int count = 100;
boolean area = false;
boolean lines = false;
boolean hidden = false;
boolean place;
color c1, c2, c3;
boolean dragging = false;
color[] col = new color[count];
boolean flag = true;

void setup() {
  size(600, 600, P3D); //<>//
  smooth();
  pList = new ArrayList<Particle>();
  
  for (int i=0; i<count; i++) {
    col[i] = color(random(255), random(255), random(255));
    pv = new PVector(random(-150, 150), random(-150, 150), random(-150, 150));
    Particle p = new Particle(pv);
    pList.add(p);
  }
}

void draw() {
  background(40);
  noStroke();
  lights();
  translate(width/2, height/2);
  rotateX( map(mouseY,0,height,0,TWO_PI));
  rotateY( map(mouseX,0,width,0,TWO_PI));
 
  for (int i=0; i<pList.size(); i++) {
    if(i<count){
      fill(col[i]);
    }else{
      fill(col[i-100]);
    }
    Particle p1 = (Particle) pList.get(i);
    p1.display();
    p1.update();
    for(int j=i+1; j<pList.size(); j++) {
      Particle p2 = (Particle) pList.get(j);
        p2.update();   
        if(dist(p1.location.x, p1.location.y, p2.location.x, p2.location.y) < distance){
          for(int k=j+1; k<pList.size(); k++){
            Particle p3 = (Particle) pList.get(k);
            p3.update();
            PShape line = createShape(LINE, p1.location.x, p1.location.y, p2.location.x, p2.location.y);
            line.setStroke(color(255));  
        }
        }
    }
  }
}

void mousePressed(){
  pv = new PVector(mouseX, mouseY, 0);
  pList.add(new Particle(pv));
}
  

class Particle {
  PVector location, speed;
  float xSpeed, ySpeed, zSpeed;
  int radius = 200;
  int edge = 15;

  Particle(PVector _pv) {
    location = _pv;
    xSpeed = random(-0.01, 0.01);
    ySpeed = random(-0.01, 0.01);
    zSpeed = random(-0.01, 0.01);
    speed = new PVector(xSpeed, ySpeed, zSpeed);
  } 


  void display() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    sphere(2);
    popMatrix();
  }
  
  void makeEdge() {
    if (dist(location.x, location.y, 0, 0)< edge) {
      xSpeed =- xSpeed;
      ySpeed =- ySpeed;
    }
    if (dist(location.x, location.z, 0, 0)> edge) {
      xSpeed =- xSpeed;
      zSpeed =- zSpeed;
    }
    if (dist(location.y, location.z, 0, 0)< edge) {
      zSpeed =- zSpeed;
      ySpeed =- ySpeed;
    }    
  }

  void update() {
    location.x += xSpeed;
    location.y += ySpeed;
    location.z += zSpeed;
    
    if (dist(location.x, location.y, 0, 0)> radius) {
      xSpeed =- xSpeed;
      ySpeed =- ySpeed;
    }
    if (dist(location.x, location.z, 0, 0)> radius) {
      xSpeed =- xSpeed;
      zSpeed =- zSpeed;
    }
    if (dist(location.y, location.z, 0, 0)> radius) {
      zSpeed =- zSpeed;
      ySpeed =- ySpeed;
    }
  }
}

/*

void mouseDragged() {
  dragging = true;
}

void mouseReleased() {
  dragging = false;
}

void mousePressed() {
  place = true;
}

void keyPressed() {
 if (key=='Q' || key=='q') {
 area = !area;
 }
 if (key=='A' || key=='a') {
 hidden = !hidden;
 }
 } */