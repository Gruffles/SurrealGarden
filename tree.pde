class tree {
  float rootX, rootY;
  float ang, prefAng;
  float branchLength;
  int numberChild;
  int tier;
  float angle = -HALF_PI;
  float maxAng = HALF_PI*0.75;


  float resistance;//the resistance of the branch, when moved
  float flyBackForce;//the angular force pulling the branch back 

  PVector targetForce;
  PVector remainder;//the remainder, to return to my parent

  //pointers to the children and parent of this branch
  tree[] children;
  tree  parent;

  tree(float _x, float _y, float _l) {//make a branch standing on the ground
    rootX = _x;
    rootY = _y;
    parent=null;
    tier = 1;
    prefAng = angle;
    numberChild = (int) random(2, 3);
    resistance=150;
    flyBackForce=0.9;
    branchLength=_l;
    children = new tree[numberChild];
    for (int i = 0; i < numberChild; i++) {
      children[i] = new tree(this, flyBackForce/1.4, resistance/1.4, branchLength/1.4, maxAng*(random(75, 125)/100), random(-maxAng/2, maxAng/2));
    }
    targetForce=new PVector(0, 0, 0);
    remainder=new PVector(0, 0, 0);
  }


  tree(tree _parent, float fbf, float res, float _l, float maxAng, float _ang) {//make a branch from a parent branch
    rootX = _parent.getTopX();
    rootY = _parent.getTopY();
    parent=_parent;
    tier = _parent.tier + 1;
    ang = _ang;  
    prefAng = _ang;
    numberChild = (int) random(tier, 1.5*tier);
    resistance=res;
    flyBackForce=fbf;
    branchLength=_l;
    if (tier<random(3, 8)) {
      children = new tree[numberChild];
      for (int i = 0; i < numberChild; i++) {
        children[i] = new tree(this, fbf/1.1, res/1.2, branchLength/(1+random(0,1.5)), maxAng*(random(75, 125)/100), random(-maxAng, maxAng));
      }
    } else {
      children = null;
    }
    targetForce=new PVector(0, 0, 0);
    remainder=new PVector(0, 0, 0);
  }


  float getAng() {
    if (parent!=null) {
      return ang+parent.getAng();
    } else {
      return ang;
    }
  }//get the angle of this, when taking in acount, all angles of the parents


  float getBaseX() {
    return cos(getAng())*branchLength;
  }
  float getBaseY() {
    return sin(getAng())*branchLength;
  }

  float getTopX() {
    return rootX+cos(getAng())*branchLength;
  }
  float getTopY() {
    return rootY+sin(getAng())*branchLength;
  }

  void display() {
    stroke(2,10,0,99);
    fill(0,10,0);
    float girth = 16/tier;
    float tipGirth = 8/tier;
    quad(rootX-girth/2, rootY, rootX+girth/2, rootY, getTopX()+tipGirth/2, getTopY(), getTopX()-tipGirth/2, getTopY());
    //line(rootX, rootY, getTopX(), getTopY());
    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].display();
      }
    }
  }
  
  void update(PVector wind) {
    beAtracted(wind);
    branchUpdate();
    display();
  }
  void branchUpdate(){//update, this branch, and all of it's children
    if (parent != null) {
      rootX = parent.getTopX();
      rootY = parent.getTopY();
    }
    float distance=ang-prefAng;//the angular distance, between the prefered angle, and the angle
    distance*= (distance>0) ? 1 : -1;
    if (ang>prefAng+0.001) {
      ang-=flyBackForce*distance;
    } else if (ang<prefAng-0.001) {
      ang+=flyBackForce*distance;
    } else {
      ang=prefAng;
    }

    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        children[i].branchUpdate();
      }
    }
    
  }
  PVector beAtracted(PVector _targetForce) {
    targetForce.set(_targetForce);
    targetForce.y = getBaseY();
    float angToMove=0;//the angle to move
    if (children != null) {
      for (int i = 0; i < children.length; i++) {
        targetForce.add(children[i].beAtracted(_targetForce));
      }
    }
    float angDiff = getAng()+atan2(targetForce.x, targetForce.y);
    angToMove+=cos(angDiff)*targetForce.mag()/(resistance*branchLength);
    ang+=angToMove;
    float remainderStrength=sin(angDiff)*targetForce.mag();
    remainder.set(remainderStrength*cos(getAng()), remainderStrength*sin(getAng()));
    return remainder;
  }
}