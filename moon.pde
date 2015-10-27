class moon
{
  
  void displayMoon()
  {
    noStroke();
    fill(160, 160, 160);
    ellipseMode(CENTER);
    ellipse(width/5, 150, width/10, width/10);
    float i=5;
    while (true)
    {
      fill(192, 192, 192, 16-i); //rays around the sun
      ellipse(width/5, 150, i*width/30, i*width/30);
      i = i+0.4;
      if (i>10) break;
    }
  }
  void displaySun()
  {
    noStroke();
    fill(251, 255, 105);
    ellipseMode(CENTER);
    ellipse(width/5, 150, width/10, width/10);
    float i=5;
    while (true)
    {
      fill(251, 255, 105, 16-i); //rays around the sun
      ellipse(width/5, 150, i*width/30, i*width/30);
      i = i+0.25;
      if (i>10) break;
    }
  }
}