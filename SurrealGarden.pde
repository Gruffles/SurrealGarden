import de.voidplus.leapmotion.*;

tree tree1;
tree tree2;
ArrayList<grass> grasses = new ArrayList<grass>(); //lol at grasses
PVector wind;
insectParticleSystem insectPS;
sky sky = new sky();
LeapMotion leap;


void setup() {
  size(1000, 800);
  tree1 = new tree(width/2+width/4, height, height/4);
  tree2 = new tree(width/4, height, height/4);
  for (int i = 0; i < width; i += random (5, 20)) {
    grasses.add(new grass(i, random(5, 50)));
  }
  wind = new PVector(0, 1, 0);
  insectPS = new insectParticleSystem(wind);
  leap = new LeapMotion(this);
}

void draw() {
  sky.update();
  stroke(255, 0, 255);
  line(width/2, height/2, width/2+wind.x*5, height/2+wind.y*5);
  stroke(0);
  //wind.update();
  treeUpdate(tree1);
  treeUpdate(tree2);
  insectPS.update();
  windUpdate();

  for (grass grass : grasses) {
    grassUpdate(grass);
  }
}

void treeUpdate(tree currentTree) {
  currentTree.beAtracted(wind);
  currentTree.update();
  currentTree.display();
}

void grassUpdate(grass currentGrass) {
  currentGrass.update(wind.x); 
  currentGrass.display();
}

PVector getFingerPos() {
  for (Hand hand : leap.getHands ()) {
    for (Finger finger : hand.getFingers ()) {
      if (finger.getType() == 1) {
        return finger.getPosition();
      }
    }
  }
  return null;
}

void windUpdate(){
  PVector currentPos = getFingerPos();
  if (currentPos != null){
    if (getFingerPos().x < width/2 && wind.mag()<50) wind.x -= 1;
    else if (getFingerPos().x > width/2 && wind.mag()>1) wind.x += 1;
    if (getFingerPos().y < height/2) wind.rotate(radians(-10));
    else if (getFingerPos().y > height/2) wind.rotate(radians(10));
  }
}

void keyPressed(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == LEFT) {
      wind.rotate(radians(-10));
    }
    if (keyCode == RIGHT) {
      wind.rotate(radians(10));
    }
    if (keyCode == UP && wind.mag()<50) {
      wind.setMag(wind.mag()+1);
    }
    if (keyCode == DOWN && wind.mag()>1) {
      wind.setMag(wind.mag()-1);
    }
  }
}

