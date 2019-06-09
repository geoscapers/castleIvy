class VoxelCastle {
  
  Voxels voxels;
  
  XoroShiro random = new XoroShiro();

  long seed;
  
  int volumeX = 100;
  int volumeY = 70;
  int volumeZ = 100;
  
  VoxelCastle(float voxelSize, float posX, float posY, float posZ, long seed) {
    voxels = new Voxels(voxelSize, volumeX, volumeY, volumeZ);
    voxels.position.x += posX;
    voxels.position.y += posY;
    voxels.position.z += posZ;
    this.seed = seed;
    random.setSeed(seed);
    
    //generateRubble(60, 50, 4, 400, seed + 1);
    //generateRubble(65, 55, 6, 700, seed + 3);
    //generateTower(50, 0, 50, 8, 4, 8, 3, 2, 0.5f, 42);
    
    generateCastle(42);
    
    //generateRoom(50, 0, 50, 8, 16, 8);
    
  }
  
  void draw() {
    voxels.draw();
  }
  
  
  void generateCastle(long seed) {
    random.setSeed(seed);
  
    // Lets have some rubble
    int rubblePiles = random.nextInt(5, 20);
    for (int i = 0; i < rubblePiles; i++) {
      generateRubble(random.nextInt(30, volumeX - 30), random.nextInt(30, volumeX - 30), random.nextInt(4, 10), random.nextInt(10, 300), seed + i + 11);     
    }
    
    int baseY = 20;
    
    // Default castle
    //  generateWalls(50, 0, 55, 30, 23, 5, 4, 8, 1, 4, seed + 6);

    // Generate several concentric castles
    int castleNum = 3;
    for (int i = 0; i < castleNum; i++) {
      float relCenter = map(i, 0, castleNum-1, 0, 1);
      float baseSize = map(i, 0, castleNum -1, volumeX * 0.6, volumeX * 0.2);
      int minLevels = (int) map(relCenter, 0, 1, 1, 3);
      generateWalls(
        (int) random.nextGaussianFloat(volumeX/2, baseSize*0.2),
        baseY,
        (int) random.nextGaussianFloat(volumeZ/2, baseSize*0.2),
        (int) random.nextGaussianFloat(baseSize, baseSize*0.2),
        (int) random.nextGaussianFloat(baseSize, baseSize*0.2),
        random.nextInt(i*2, 3 + i * 4),
        random.nextInt(4, 6),
        random.nextInt(4, 10),
        minLevels,
        random.nextInt(minLevels + i, minLevels + i * 2),
        baseY,
        seed + 17 * i);
    }
    
    // Central tower
    generateTower(volumeX/2, baseY, volumeZ/2, 12, 12, 10, 4, 3, 0.8, baseY, seed + 71);
  }
  
  void generateWalls(int centerX, int baseY, int centerZ, int sizeX, int sizeZ, int wallHeight, int wallWidth, int towerDiam, int towerMinLevels, int towerMaxLevels, int foundationDepth, long seed) {
    random.setSeed(seed);
    float windowProb = 0.5;
    generateTower(centerX - sizeX/2, baseY, centerZ - sizeZ/2, towerDiam, towerDiam, 8, random.nextInt(towerMinLevels,towerMaxLevels), 2, windowProb, foundationDepth, seed+1);
    generateTower(centerX + sizeX/2, baseY, centerZ - sizeZ/2, towerDiam, towerDiam, 8, random.nextInt(towerMinLevels,towerMaxLevels), 2, windowProb, foundationDepth, seed+2);
    generateTower(centerX - sizeX/2, baseY, centerZ + sizeZ/2, towerDiam, towerDiam, 8, random.nextInt(towerMinLevels,towerMaxLevels), 2, windowProb, foundationDepth, seed+3);
    generateTower(centerX + sizeX/2, baseY, centerZ + sizeZ/2, towerDiam, towerDiam, 8, random.nextInt(towerMinLevels,towerMaxLevels), 2, windowProb, foundationDepth, seed+4);
    
    int wallsOverhang = 0;
    generateTower(centerX + sizeX/2, baseY, centerZ, wallWidth, sizeZ, wallHeight, 1, wallsOverhang, 0f, foundationDepth, seed+7);
    generateTower(centerX - sizeX/2, baseY, centerZ, wallWidth, sizeZ, wallHeight, 1, wallsOverhang, 0f, foundationDepth, seed+8);
    generateTower(centerX, baseY, centerZ - sizeZ/2, sizeX, wallWidth, wallHeight, 1, wallsOverhang, 0f, foundationDepth, seed+9);
    generateTower(centerX, baseY, centerZ + sizeZ/2, sizeX, wallWidth, wallHeight, 1, wallsOverhang, 0f, foundationDepth, seed+11);
  }
  
  void generateTower(int centerX, int baseY, int centerZ, int sizeX, int sizeZ, int levelHeight, int levels, int overhang, float windowProb, int foundationDepth, long seed) {
    // Rooms
    for (int level = 0; level < levels; level++) {
      generateRoom(centerX, baseY + level * levelHeight, centerZ, sizeX, levelHeight, sizeZ, windowProb, seed + level * 31);
    }
    
    // Wide roof
    int roofBase = baseY + levels * levelHeight;
    int upperWidthX = sizeX + overhang * 2;
    int upperWidthZ = sizeZ + overhang * 2;
    makeWall(centerX, roofBase, centerZ, upperWidthX, 1, upperWidthZ, false);
    
    // Crenelations
    generateCrenellations(centerX, roofBase + 1, centerZ - upperWidthZ/2, upperWidthX, false, 2, 2, 0, 2);
    generateCrenellations(centerX, roofBase + 1, centerZ + upperWidthZ/2, upperWidthX, false, 2, 2, 0, 2);
    generateCrenellations(centerX - upperWidthX/2, roofBase + 1, centerZ, upperWidthZ, true, 2, 2, 0, 2);
    generateCrenellations(centerX + upperWidthX/2, roofBase + 1, centerZ, upperWidthZ, true, 2, 2, 0, 2);
    
    // Foundation
    generateRoom(centerX, baseY - foundationDepth-1, centerZ, sizeX, foundationDepth, sizeZ, 0, seed * 12);
  }
  
  void generateRubble(int centerX, int centerZ, float radius, int count, long seed) {
    random.setSeed(seed);
    for (int i = 0; i < count; i++) {
      int x = (int) random.nextGaussianFloat(centerX, radius);
      int z = (int) random.nextGaussianFloat(centerZ, radius);
      int y = voxels.countY - 1;
      
      // Drop stone
      while(y > 0 && voxels.get(x, y - 1, z) == 0) {
        y--;
      }
      
      voxels.set(x, y, z, randomBlock(x, y, z));
    }
  }

  void generateCrenellations(int centerX, int baseY, int centerZ, int length, boolean alongX, int baseHeight, int topHeight, int gapRadius, int topLen) {
    int sizeX = 1;
    int sizeZ = 1;
    if (alongX) sizeZ = length;
    else sizeX = length;
    
    // Fill all
    makeWall(centerX, baseY, centerZ, sizeX, baseHeight + topHeight - 1, sizeZ, false);
    
    // Cutouts
    int p = 0;
    int baseX = centerX - sizeX / 2;
    int baseZ = centerZ - sizeZ / 2;
    while (p < length) {
      int c = p + (gapRadius*2+1 + topLen) / 2;
      int x = baseX;
      int z = baseZ;
      if (alongX) z += c;
      else x += c;
      
      // Clear gap
      int gr = gapRadius;
      voxels.clearVolume(x - gr, baseY + baseHeight, z - gr, x + gr, baseY + baseHeight + topHeight - 1, z + gr);
      
      p += gapRadius*2+1 + topLen;
    }
  }
  
  void generateRoom(int centerX, int baseY, int centerZ, int sizeX, int sizeY, int sizeZ, float windowProb, long seed) {
    random.setSeed(seed);
    int x1 = centerX - sizeX/2;
    int x2 = centerX + sizeX/2;
    int z1 = centerZ - sizeZ/2;
    int z2 = centerZ + sizeZ/2;
    makeWall(x1, baseY, centerZ, 1, sizeY, sizeZ, random.nextBoolean(windowProb));
    makeWall(x2, baseY, centerZ, 1, sizeY, sizeZ, random.nextBoolean(windowProb));
    makeWall(centerX, baseY, z1, sizeX, sizeY, 1, random.nextBoolean(windowProb));
    makeWall(centerX, baseY, z2, sizeX, sizeY, 1, random.nextBoolean(windowProb));

    // Base floor
    makeWall(centerX, baseY, centerZ, sizeX, 1, sizeZ, false);

    // Ceiling
    makeWall(centerX, baseY + sizeY, centerZ, sizeX, 1, sizeZ, false);
    
    // Darkness inside
    voxels.setVolume(x1+1, baseY+1, z1+1, x2-1, baseY+sizeY-1, z2-1, voxels.DARKNESS);
  }

  
  void makeWall(int centerX, int baseY, int centerZ, int sizeX, int sizeY, int sizeZ, boolean cutWindow) {
    for (int x = centerX - sizeX/2; x <= centerX + sizeX/2; x++)
      for (int y = baseY; y < baseY + sizeY; y++)
        for (int z = centerZ - sizeZ/2; z <= centerZ + sizeZ/2; z++)
          voxels.set(x, y, z, randomBlock(x, y, z));    
          
    if (cutWindow) {
      int windowRad = 1;
      int windowBase = 2;
      int windowHeight = 5;
      voxels.clearVolume(centerX - windowRad, baseY + windowBase, centerZ -windowRad, 
                         centerX + windowRad, min(baseY + windowBase + windowHeight-1, baseY + sizeY-1), centerZ + windowRad);
    }
  }

  
  
  int randomBlock(int x, int y, int z) {
    random.setSeed(x, y, z);
    
    int posBased = (int) (map(y, 0, voxels.countY, voxels.GRANITE_FIRST, voxels.GRANITE_LAST) + random.nextGaussianFloat(0f, 3f));
    if (posBased < voxels.GRANITE_FIRST) posBased = voxels.GRANITE_FIRST;
    if (posBased > voxels.GRANITE_LAST) posBased = voxels.GRANITE_LAST;
    
    return posBased;
  }



  // Returns false if no castle wall nearby.
  boolean getCastleDistance(PVector position, PVector vectorToClosestWall) {
    return voxels.getClosestBlock(position, vectorToClosestWall);
  }
  

}
