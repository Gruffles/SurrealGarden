class grass {
  float rootX, rootY;
  float len;
  float windX = 0;
  float windY = 0;

  grass(float _x, float _l) {
    rootX = _x;
    rootY = height;
    len = _l;
  }
  void display() {
    stroke(45,50,45,90);
    strokeWeight(2);
    fill(45,50,45,90);
    
    beginShape();
    curveVertex(rootX, rootY);
    curveVertex(rootX, rootY);
    curveVertex(rootX+windX*0.5*len/10, rootY-len+windY*0.2);
    curveVertex(rootX+windX*1.2*len/10, rootY-len+windY*0.3);
    vertex(rootX+5, rootY);
    curveVertex(rootX+len/5, rootY);
    curveVertex(rootX+len/5, rootY);
    curveVertex(rootX+windX*0.5*len/10, rootY-len+windY*0.2);
    curveVertex(rootX+windX*1.2*len/10, rootY-len+windY*0.3);
    vertex(rootX, rootY);
    endShape();
  }
  
  void update(float _wx, float _wy) {
    windX = _wx;
    windY = _wy;
    display(); 
  }
}