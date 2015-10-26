class wind{
  
  
PVector wind;
float windoff = 0.0;
  
 
  wind(PVector _w){
    wind = _w;
    wind.setMag(5);
  }
  
  float getx(){
    return wind.x;
  }
  float gety(){
     return wind.y; 
  }
  PVector getPVector(){
     return wind; 
  }
  
  void update(){
     println(degrees(wind.heading()) + "  " + wind.mag() + " x:" + wind.x);
    {
       windoff = windoff + .01;
       wind.rotate(radians(((noise(windoff)*40)-20)/10));
       if(wind.mag() > 50){
         wind.setMag(wind.mag() - noise(windoff));
       }
       else
       if(wind.mag() < 1){
         wind.setMag(wind.mag() + noise(windoff));
       }
       else{
         wind.setMag(wind.mag() +(noise(windoff) - wind.mag()/100 -0.25)  );
       }
    } 
  }
  void rotate(float radians){
     wind.rotate(radians);
  }

}
