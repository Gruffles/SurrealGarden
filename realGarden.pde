tree tree1;
tree tree2;
ArrayList<grass> grasses = new ArrayList<grass>(); //lol at grasses
wind wind;
insectParticleSystem insectPS;
sky sky = new sky();


void setup() {
  size(1000, 800);
  tree1 = new tree(width/2+width/4, height, height/4);
  tree2 = new tree(width/4, height, height/4);
  for (int i = 0; i < width; i += random(1, 10)) {
    grasses.add(new grass(i, random(5,50)));
  }
  wind = new wind(new PVector(1, 1, 1));
  insectPS = new insectParticleSystem(wind);
}

void draw() {
  sky.update();
  stroke(255, 0, 255);
  line(width/2, height/2, width/2+wind.getx()*5, height/2+wind.gety()*5);
  stroke(0);
  wind.update();
  tree1.update(wind.getPVector());
  tree2.update(wind.getPVector());
  insectPS.update(); 
  
  for (grass grass : grasses){
     grass.update(wind.getx(), wind.gety());
     //println("yep");
  }
  
}

//void keyPressed(KeyEvent e) {
//  if (key == CODED) {
//    if (keyCode == LEFT) {
//      wind.rotate(radians(-10));
//    }
//    if (keyCode == RIGHT) {
//      wind.rotate(radians(10));
//    }
//    if (keyCode == UP && wind.mag()<50) {
//      wind.setMag(wind.mag()+1);
//    }
//    if (keyCode == DOWN && wind.mag()>1) {
//      wind.setMag(wind.mag()-1);
//    }
//  }
//}