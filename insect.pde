class insectParticleSystem
{
  ArrayList<insect> insects;
  PVector wind;
  float cooldown = 0;

  insectParticleSystem(PVector _w)
  {
    insects = new ArrayList<insect>();
    wind = _w;
  }

  void addInsect()
  {
    if (cooldown < 1)
    {
      insects.add(new insect(wind)); 
      cooldown = random(5, 15);
    } else
    {
      cooldown--;
    }
  }

  void update()
  {
    addInsect();
    for (int i = insects.size ()-1; i >= 0; i--) {
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
  PVector wind;

  insect(PVector _w)
  {
    wind = _w;
    float origin = 0.0;
    if (wind.x > 0)
    {
      origin = random(-10, width/2);
    } else
    {
      origin = random(width/2, width +10);
    }
    location = new PVector(origin, random(0, height-15));
    velocity = new PVector(wind.x/10, random(-5, 5));
    opacity = 0.0;
  }

  void run()
  {
    update();
    display();
  }

  void update()
  {
    velocity.set(wind.x, wind.y);
    location.add(velocity);
    if (opacity < 90 && !decay) {
      opacity += 5;
    } else {
      decay = true;
      opacity -= 1;
    }
  }

  void display()
  {
    stroke(0, 0, 0, opacity);
    strokeWeight(3);
    fill(0, opacity);
    ellipse(location.x, location.y, 10, 10);
  }

  boolean isDead()
  {
    if ( opacity<5 ) return true;
    else return false;
  }
}

