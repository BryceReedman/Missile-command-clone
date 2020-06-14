int firingBase() {
  //returns the index of the base that should be firing the shots.
  //if no bases present returns -1 indexError
  int baseSelect=-1;
  //sets a very large number, larger than possible.
  int xDist = width + 10;
for (int i = 0; i < bases.length; i++) {
  if (bases[i].notHit == true) {
    if (abs(mouseX - bases[i].x) < xDist) {
      xDist = abs(mouseX - bases[i].x);
      baseSelect = i;
    }

  }
}
  return baseSelect;
  
}
