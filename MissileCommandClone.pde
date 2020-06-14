Missile[] missiles;
Building[] cities;
Building[] bases;
//Building city;
void setup() {
  size(1000, 600);
  cities = new Building[5];
  bases = new Building[4];
  missiles = new Missile[0];
  //used to plot the bases between each city. added one to offset it so that it will
  //place then nice looking
  int pointBetweenCities = width/(cities.length+1) + (width/(cities.length+1)) / 2;
  //places the cities evenly
  int x = width/(cities.length+1);
  for (int i = 0; i < cities.length; i++) {
    cities[i] = new Building(x, true);    
    x += width/(cities.length+1);
  }
  //places bases between the cities
  int y = pointBetweenCities;
  for (int i = 0; i < bases.length; i++) {
    bases[i]= new Building(y, false);
    y += width/(cities.length+1);
  }
}

void draw() {
  background(128);
  //draws the cities
  for (Building item : cities) {
    fill(255);
    item.draw();
  }

  //draws the bases
  for (Building item : bases) {
    fill(0);
    item.draw();
  }

  //handles missiles
  iterate();
}

void mousePressed() {
  PVector pos = new PVector(bases[firingBase()].x, height);
  
  PVector mouse = new PVector(mouseX, mouseY);
  PVector vel = new PVector();
  vel.add(mouse);
  vel.sub(pos);
  vel.normalize();
  vel.setMag(3);
   
  float angle = vel.heading() + PI/2;
 
  missiles = (Missile[]) append(missiles, new Missile(pos, vel, true, angle));
}
