class insectParticleSystem
{
  ArrayList<insect> insects;
  wind wind;
  float cooldown = 0;
  
  insectParticleSystem(wind _w)
  {
    insects = new ArrayList<insect>();
    wind = _w;
  }
  
  void addInsect()
  {
    if(cooldown < 1)
    {
       insects.add(new insect(wind)); 
       cooldown = random(20,60);
    }
    else
    {
      cooldown--;
    }
  }
  
  void update()
  {
    addInsect();
    for (int i = insects.size()-1; i >= 0; i--) {
      insect p = insects.get(i);
      p.run();
      if (p.isDead()) {
        insects.remove(i);
      }
    }
  }
  
}

class insect
{
  PVector location, velocity;
  float opacity;
  boolean decay = false;
  float yoff;
  wind wind;
  
  insect(wind _w)
  {
    wind = _w;
    float origin = 0.0;
    if(wind.getx() > 0)
    {
      origin = random(-10, width/2);
    }
    else
    {
      origin = random(width/2, width +10); 
    }
    location = new PVector(origin, random(0, height-15));
    velocity = new PVector(wind.getx()/10, random(-5,5));
    opacity = 0.0;
  }
  
  void run()
  {
     update();
     display();
  }
  
  void update()
  {
    yoff += 0.03;
    
    velocity.set((noise(yoff)-0.5)*20+wind.getx(), (noise(yoff)-0.5)*20);
    location.add(velocity);
    if(opacity < 90 && !decay){
      
      opacity += 10;
    }else{
      decay = true;
      opacity -= 1;
    }
  }
  
  void display()
  {
    stroke(255,255,50,opacity+20);
    strokeWeight(3);
    fill(0,opacity);
    ellipse(location.x, location.y, 4, 4);
  }
  
  boolean isDead()
  {
    if( opacity<5 )
    {
      println("Dead");
      return true;
    }
    else{
      return false;
    }
  }
  
}