

void getCastleDistance(PVector position, PVector vectorToClosestWall) {
  
  float centerX = 0;
  float centerZ = 0;
  float radius = 3;
  
  vectorToClosestWall.set(
    centerX - position.x,
    0,
    centerZ - position.z);
}
