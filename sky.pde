
color summerMorning = color(100, 150, 100);
color summerMidday = color(200, 200, 200);
color summerAfternoon = color(150, 100, 100);
color summerNight = color(30, 10, 20);

color winterMorning = color(100, 100, 150);
color winterMidday = color(200, 200, 220);
color winterAfternoon = color(150, 100, 150);
color winterNight = color(15, 15, 25);

float dayLength = 30;
double hour = 0;//30 hours in a day, 1 hour = 1 sec
float mills;

String season = "summer";

void update() {
  mills = millis();
  hour = (mills/1000) % dayLength;
  if (season == "summer") {
    if (hour > 0 && hour <= 6) setGradient(summerNight, summerMorning, 6, 0, hour);
    else if (hour > 6 && hour <= 15) setGradient(summerMorning, summerMidday, 9, 6, hour);
    else if (hour > 15 && hour <= 24) setGradient(summerMidday, summerAfternoon, 9, 15, hour);
    else if (hour > 24 && hour <= 31) setGradient(summerAfternoon, summerNight, 6, 24, hour);
  }
  if (season == "winter") {
    if (hour > 0 && hour <= 6) setGradient(winterNight, winterMorning, 6, 0, hour);
    else if (hour > 6 && hour <= 15) setGradient(winterMorning, winterMidday, 9, 6, hour);
    else if (hour > 15 && hour <= 24) setGradient(winterMidday, winterAfternoon, 9, 15, hour);
    else if (hour > 24 && hour <= 31) setGradient(winterAfternoon, winterNight, 6, 24, hour);
  }
}

void setGradient(color c1, color c2, float cycleLen, float startTime, double hour) {
  noFill();
  for (int i = 0; i <= height; i++) {
    float inter = map(i, 0, height, (float)(hour-startTime)/cycleLen*0.5, (float)(hour-startTime)/cycleLen*1.1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(0, i, width, i);
  }
}