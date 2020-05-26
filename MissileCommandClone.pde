Missile[] missiles;
Building[] cities;
Building[] bases;
//Building city;
void setup() {
  size(1000, 600);
  cities = new Building[6];
  bases = new Building[3];


  int y = width/(bases.length);
  for (int i = 0; i < bases.length; i++) {
    bases[i]= new Building(y, false);
    print("did");
      y += width/(cities.length + 5);
  }
  int x = width/(cities.length + 5);
  for (int i = 0; i < cities.length; i++) {
    cities[i] = new Building(x, true);    
    x += width/cities.length;
  }
}

void draw() {
  background(255);
  for (Building item : cities) {
    fill(255);
    item.draw();
  }

  for (Building item : bases) {
    fill(0);
    item.draw();
  }
}
