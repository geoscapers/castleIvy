

void getCastleDistance(PVector position, PVector vectorToClosestWall) {
  
  float centerX = 0;
  float centerZ = 0;
  float radius = 3;
  
  vectorToClosestWall.set(
    centerX - position.x,
    0,
    centerZ - position.z);
}




class Castle {
  HashMap<Int3, Cell> cells = new HashMap();
  
  
}


class Cell {
  Int3 location = new Int3();
  
  
  void draw() {
  }
}
