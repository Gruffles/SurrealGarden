class rain
{
  float x = random(width+400);
  float y = random(-height);
  float wind = 0;

  void fall() 
  {
    y += 10;
    x += wind/4;
    fill(204,229,255);
    ellipse(x, y, 5, 9);

    if(y>height)
    {
      x = random(width+400);
      y = random(-200);
    }
  }
  void update(float _w) //for wind interaction
  {
    wind = _w;
    fall();
  }
}