class grass {
  float rootX, rootY;
  float len;
  float wind = 0;
  float curve;
  boolean direction;


  grass(float _x, float _l) {
    rootX = _x;
    rootY = height;
    len = _l;
    curve = random(1, 10);
    direction = (random(1) > .5);
  }
  void display() {
    stroke(0);
    strokeWeight(1);
    fill(0);
    beginShape();
    curveVertex(rootX, rootY);
    curveVertex(rootX+(wind/6), rootY-(len/2));
    curveVertex(rootX+(wind/3), rootY-len);
    if (direction){
      curveVertex(rootX-curve, rootY);
      curveVertex(rootX-(curve/2), rootY);
    }
    else {
     curveVertex(rootX+curve, rootY); 
     curveVertex(rootX+(curve/2), rootY); 
    }
    curveVertex(rootX, rootY);
    endShape();
  }

  void update(float _w) {
    wind = _w;
  }
}