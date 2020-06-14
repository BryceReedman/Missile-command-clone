class Missile {
  // keep track of where the explosion should occur relative to the
  // y axis
  int yExplosion;
  // max radius of explosion before expire
  int maxRadius = 70;
  // vectors
  PVector pos;
  PVector vel;
  // used to check if missile object is old
  boolean expired = false;
  float angle;

  // explosion
  int radius=0;
  boolean shrink = false;
  boolean friendly;
  boolean isExploding;


  Missile(PVector pos, PVector vel, boolean friendly, float angle) {
    //create new missile
    // velocity will be in the direction of the missile launcher base
    if (!friendly) {
      yExplosion = 0;
    } else {
      yExplosion = mouseY;
    }
    this.pos = pos;
    this.friendly = friendly;
    this.vel = vel;
    this.angle = angle;
  }
  //once the missile has reached desired location, stop moving
  void update() {
    if (!(pos.y <= yExplosion)) {
      pos.add(vel);
    }
  }

  void draw() {
    if (!isExploding) {
      pushMatrix();
      translate(pos.x, pos.y);
      rectMode(CENTER);
      rotate(angle);
      fill(255);
      stroke(0);
      rect(0, 0, 5, 15);

      translate(-pos.x, -pos.y);
      popMatrix();


    }
  }


  void explosion() {
    if (pos.y <= yExplosion) {
      isExploding = true; //<>//

      if (radius >= maxRadius) {
        shrink = true;
      }
      if ( !shrink) {
        radius++; //<>//
      } else {
        radius-= 2; //<>//
      }
      if (!(radius <= 0)) { //<>//
        ellipse(pos.x, pos.y, radius, radius);
      }
    }
  }


  void collision() {
    if (this.isExploding) {
      //missile collision check
      for (Missile other : missiles) {
        if (other.pos.dist(pos) < radius & other.isExploding == false) {
          other.expired = true;
        }
        if (!this.friendly) {
          //building collision check
          for (Building building : bases) {
            if (dist(building.x, height, pos.x, pos.y) < radius) {
              building.notHit = false;
            }
          }
        }
      }
    }
  }
}



void iterate() {
  for (Missile a : missiles) {
    if (!a.expired) {
      a.draw();
      a.update();
      a.explosion();
     a.collision();
    }
  }
}

class Building {
  boolean city;
  boolean notHit=true;
  int x;
  float noiseNum = random(0.0, 2.0);
  Building(int x, boolean city) {
    this.x = x;
    this.city = city;
  }

  void draw() {
    if (notHit) {
      int left = 0;
      int right = 0;
      rectMode(CORNER);
      pushMatrix();

      while (left > -30) {
        left-= 10;
        translate(-10, 0);
        float heightOfTowerL = map(noise(noiseNum + left), 0, 1, 10, 50);
        rect(x, height - heightOfTowerL, 10, heightOfTowerL);
      }
      popMatrix();
      pushMatrix(); 
      while (right < 30) {
        float heightOfTowerR = map(noise(noiseNum + right), 0, 1, 10, 50);
        rect(x, height - heightOfTowerR, 10, heightOfTowerR);
        translate(10, 0);
        right+= 10;
      }
      popMatrix();
    }
  }
}
