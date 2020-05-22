class Missile {
  // keep track of where the explosion should occur relative to the
  // y axis
  int yExplosion;
  // max radius of explosion before expire
  int maxRadius = 40;
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


  Missile(PVector pos, float angle, boolean friendly) {
    //create new missile
    // velocity will be in the direction of the missile launcher base
    if (!friendly) {
      yExplosion = 0;
    } else {
      yExplosion = mouseY;
    }
    this.pos = pos;
    this.vel = PVector.fromAngle(radians(angle));
    this.friendly = friendly;
    this.angle = angle;
  }

  void update() {
    if (!(pos.x >= yExplosion)) {
      pos.add(vel);
    }
  }

  void draw() {
    if (!isExploding) {
      pushMatrix();
      translate(pos.x, pos.y);
      rectMode(CENTER);
      rect(pos.x, pos.y, 5, 15);
      rotate(radians(angle));
      translate(-pos.x, -pos.y);
      popMatrix();
    }
  }


  void explosion() {
    if (pos.x >= yExplosion) {
      isExploding = true;

      if (radius >= maxRadius) {
        shrink = true;
      }
      if ( !shrink) {
        radius++;
      } else {
        radius--;
      }
      ellipse(pos.x, pos.y, radius, radius);
    }
  }


  void collision(Missile missile) {
    if (missile.isExploding) {
      for (Missile other : missiles) {
        if (other.pos.dist(pos) < radius) {
          other.expired = true;
        }
        if (!missile.friendly) {
          // implement building collision check
        }
      }
    }
  }
}

void iterate() {
  for (Missile a : missiles) {
    if (!a.expired) {
      a.update();
      a.explosion();
      a.draw();
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
