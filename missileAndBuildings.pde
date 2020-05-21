class Missile {
	// keep track of where the explosion should occur relative to the
	// y axis
	int yExplosion;
	// max radius of explosion before expire
	int maxRadius;
	// vectors
	PVector pos;
	PVector vel;
	// used to check if missile object is old
	boolean expired = false;

	// explosion
	int radius=0;
	boolean shrink = false;
	boolean friendly;
	boolean isExploding;
	Missile(pos, angle, friendly, yExplosion) {
		//create new missile
		// velocity will be in the direction of the missile launcher base
		if (!friendly) {
			yExplosion = 0;
		}
		else {
			yExplosion = mouseY;
		}
		this.pos = pos;
		this.vel = PVector.fromAngle(radians(angle));
		this.friendly = friendly;
	}

	void update() {
		if (!pos.x >= yExplosion) {
				pos.add(vel);
		}
	
	}

	void draw() {
		// todo
	}


	void explosion() {
		if (pos.x >= yExplosion) {
			
		
			if (radius >= radiusMax) {
				shrink = true;
			}
			if ( !shrink) {
				radius++;
				ellipse(pos.x, pos.y, radius);
			}
			else {
				radius--;
				ellipse(pos.)
			}
		}
	}
}

void iterate() {
	for (Missile a : missiles) {
		if (!a.expired) {
			a.upate();
			a.explosion();
			a.draw();
		}
	}
}

void collision(missile) {
	if (missile.isExploding) {
		for (Missile other : missiles) {
			if other.pos.dist(pos) < radius {
				other.expired = true;
			}
			if (!missile.friendly) {
				// implement building collision check
			}
		}
		
	}
}