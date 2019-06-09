

/** Actually, we need a voxelengine too!  Lets keep it simple with one chunk and limited world size.  */
class Voxels {
  
  int countX;
  int countY;
  int countZ;

  byte voxels[][][];
  
  color blockColors[];
  
  int VOID = 0;
  int DARKNESS = 1;
  int GRANITE_FIRST = 2;
  int GRANITE_LAST = 50;
  
  float voxelSize = 0.25f;
  
  PVector position = new PVector();
  
  private boolean redrawNeeded = true;
  
  private PShape shape;
  
  private PVector tempCenter = new PVector();
  
  private int byteToUnsignedMask = 0xFF;
  
  private XoroShiro random = new XoroShiro(1234);
  
  Voxels(float voxelSize, int countX, int countY, int countZ) {
    
    this.voxelSize = voxelSize;
    this.countX = countX;
    this.countY = countY;
    this.countZ = countZ;
  
    blockColors = new color[256];
    initBlockColors();
  
    // Center x and z
    position.set(-countX * voxelSize / 2f, 0, -countX * voxelSize / 2f);
    
    // Allocate the matixes!
    voxels = new byte[countX][countY][countZ];
  }

  void set(int x, int y, int z, int type) {
    if (x >= 0 && x < countX && 
        y >= 0 && y < countY && 
        z >= 0 && z < countZ) {
      voxels[x][y][z] = (byte)type;
    }
  }
  
  int get(int x, int y, int z) {
    if (x >= 0 && x < countX && 
        y >= 0 && y < countY && 
        z >= 0 && z < countZ) {
      return voxels[x][y][z] & byteToUnsignedMask;
    }
    else {
      return 0;
    }
  }
  
  boolean isSolid(int x, int y, int z) {
    return get(x, y, z) != 0;
  }

  void clearVolume(int x1, int y1, int z1, 
                   int x2, int y2, int z2) {
    setVolume(x1, y1, z1, x2, y2, z2, 0);
  }

  void setVolume(int x1, int y1, int z1, 
                 int x2, int y2, int z2, 
                 int type) {
                        
    int x = x1;
    int y = y1;
    int z = z1;
    
    /*
    // Swap so x1 is smaller than x2, etc.
    if (x2 < x1) {
      x1 = x2;
      x2 = x;
    }
    if (y2 < y1) {
      y1 = y2;
      y2 = y;
    }
    if (z2 < z1) {
      z1 = z2;
      z2 = z;
    }
    */
    
    // Fill x1 .. x2 etc with blocks (inclusicve)
    for (x = x1; x <= x2; x++)
      for (y = y1; y <= y2; y++)
        for (z = z1; z <= z2; z++)
          set(x, y, z, type);
  }

  void clear(int x, int y, int z) {
    set(x, y, z, 0);
  }

  void initBlockColors() {
    // These need to multiply up to 255
    int hueCount = 8;
    int satCount = 8;
    int lumCount = 4;
    
    // Palette with hues with various saturations and brightness runs
    int colorIndex = 0;
    for (int sat = 0; sat < satCount; sat++) {
      for (int lum = 0; lum < lumCount; lum++) {
        for (int hue = 0; hue < hueCount; hue++) {
          blockColors[colorIndex++] = color((hue+1) * 100/hueCount, 
                                            map((sat+1) * 100/satCount, 0, 100, 0, 10), 
                                            map((lum+1) * 100/lumCount, 0, 100, 40, 60));
        }
      }
    }
    
    // Purposeful named colors
    blockColors[DARKNESS] = color(0, 0, 0);    
    for (int i = GRANITE_FIRST; i <= GRANITE_LAST; i++) {
      float p = map(i, GRANITE_FIRST, GRANITE_LAST, 0, 1);
      blockColors[i] = color(map(p, 0, 1, 70, 10) + random.nextGaussianFloat(0f, 5f), 
                             map(p, 0, 1, 30, 20) + random.nextGaussianFloat(0f, 5f), 
                             map(p, 0, 1, 40, 70) + random.nextGaussianFloat(0f, 5f));
    }
    
  }


  void toWorldPos(int x, int y, int z, PVector out) {
    out.x = (x + 0.5f) * voxelSize + position.x;
    out.y = (y + 0.5f) * voxelSize + position.y;
    out.z = (z + 0.5f) * voxelSize + position.z;
  }

  private void setVectorToBlock(int x, int y, int z, PVector pos, PVector deltaOut) {
    toWorldPos(x, y, z, deltaOut);
    deltaOut.sub(pos);
  }


  private PVector tempDelta = new PVector();
  boolean getClosestBlock(PVector pos, PVector vectorToClosestWall) {
    int voxelX = (int) ((pos.x - position.x) / voxelSize);
    int voxelY = (int) ((pos.y - position.y) / voxelSize);
    int voxelZ = (int) ((pos.z - position.z) / voxelSize);
    
    // Check if we found it.
    if (isSolid(voxelX, voxelY, voxelZ)) {
      setVectorToBlock(voxelX, voxelY, voxelZ, pos, vectorToClosestWall);
      return true;
    }
    
    int searchRadius = 8; // Look this many blocks in all directions for a solid block
    for (int i = 1; i < searchRadius; i++) {
      
      // This recalculates the insides multiple times, but it's 3 am and we got 9 hours left.
      // Should only add a constant factor of about 2 or so anyway.
      float closestDistSquared = -1;
      boolean foundClosestDist = false;
      for (int x = voxelX - i; x <= voxelX + 1; x++) 
        for (int y = voxelY - i; y <= voxelY + 1; y++) 
          for (int z = voxelZ - i; z <= voxelZ + 1; z++) {
            if (isSolid(x, y, z)) {
              // Hit wall, get dist
              setVectorToBlock(x, y, z, pos, tempDelta);
              float distSquared = tempDelta.magSq();
              if (!foundClosestDist || distSquared < closestDistSquared) {
                foundClosestDist = true;
                closestDistSquared = distSquared;
                vectorToClosestWall.set(tempDelta);
              }
            }
          }
          
      if (foundClosestDist) return true;  // We found a solid block, and wrote direction vector to it.  
    }

    // No matches within search radius, give up.
    return false;
  }
  


  void redraw() {
    redrawNeeded = true;
  }

  void draw() {
    if (redrawNeeded) {
      buildShape();
      redrawNeeded = false;
    }
    
    shape(shape);
  }
  
  private void buildShape() {
    shape = createShape();
    shape.beginShape(TRIANGLES);
    float xPos = 0f;
    float yPos = 0f;
    float zPos = 0f;
    
    for (int z = 0; z < countZ; z++) {
      zPos = z * voxelSize;
      for (int y = 0; y < countY; y++) {
        yPos = y * voxelSize;
        for (int x = 0; x < countX; x++) {
          xPos = x * voxelSize;
          
          int voxelType = voxels[x][y][z] & byteToUnsignedMask;
          
          if (voxelType != 0) {                          
            tempCenter.set(xPos + voxelSize * 0.5f + position.x, 
                           -(yPos + voxelSize * 0.5f + position.y), 
                           zPos + voxelSize * 0.5f + position.z);
            drawBlock(tempCenter, blockColors[voxelType]);
          }
        }
      }
    }
    shape.endShape();
  }
  
  private PVector tC = new PVector(); 
  private PVector tU = new PVector(); 
  private PVector tV = new PVector(); 
  private PVector unitX = new PVector(1, 0, 0); 
  private PVector unitY = new PVector(0, 1, 0); 
  private PVector unitZ = new PVector(0, 0, 1); 
  private void drawBlock(PVector center, color c) {
    shape.fill(c);
    
    addScaled(tC.set(center), unitX, voxelSize*0.5f);
    drawFace(tC, unitY, unitZ, false);

    addScaled(tC.set(center), unitX, -voxelSize*0.5f);
    drawFace(tC, unitZ, unitY, true);

    addScaled(tC.set(center), unitY, voxelSize*0.5f);
    drawFace(tC, unitX, unitZ, false);

    addScaled(tC.set(center), unitY, -voxelSize*0.5f);
    drawFace(tC, unitZ, unitX, true);

    addScaled(tC.set(center), unitZ, voxelSize*0.5f);
    drawFace(tC, unitY, unitX, false);

    addScaled(tC.set(center), unitZ, -voxelSize*0.5f);
    drawFace(tC, unitX, unitY, true);

  }
  
  private PVector tempA  = new PVector();
  private PVector tempB  = new PVector();
  private PVector tempC  = new PVector();
  private PVector tempD  = new PVector();
  private void drawFace(PVector center, PVector u, PVector v, boolean flip) {
    
    tempA.set(center);
    tempB.set(center);
    tempC.set(center);
    tempD.set(center);
    
    addScaled(tempA, u, -voxelSize * 0.5f);
    addScaled(tempA, v, -voxelSize * 0.5f);

    addScaled(tempB, u,  voxelSize * 0.5f);
    addScaled(tempB, v, -voxelSize * 0.5f);

    addScaled(tempC, u,  voxelSize * 0.5f);
    addScaled(tempC, v,  voxelSize * 0.5f);

    addScaled(tempD, u, -voxelSize * 0.5f);
    addScaled(tempD, v,  voxelSize * 0.5f);

    if (flip) {
      makeShapeRectangle(shape, tempA, tempB, tempC, tempD);
    }
    else {
      makeShapeRectangle(shape, tempD, tempC, tempB, tempA);
    }
  }
  
}
