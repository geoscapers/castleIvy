

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
  
  void draw() {
    pushMatrix();
    beginShape(TRIANGLES);
    
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
    
    endShape();
    popMatrix();
  }
  
  private PVector tC = new PVector(); 
  private PVector tU = new PVector(); 
  private PVector tV = new PVector(); 
  private PVector unitX = new PVector(1, 0, 0); 
  private PVector unitY = new PVector(0, 1, 0); 
  private PVector unitZ = new PVector(0, 0, 1); 
  void drawBlock(PVector center, color c) {
    fill(c);
    
    addScaled(tC.set(center), unitX, voxelSize*0.5f);
    drawFace(tC, unitY, unitZ);

    addScaled(tC.set(center), unitX, -voxelSize*0.5f);
    drawFace(tC, unitZ, unitY);

    addScaled(tC.set(center), unitY, voxelSize*0.5f);
    drawFace(tC, unitX, unitZ);

    addScaled(tC.set(center), unitY, -voxelSize*0.5f);
    drawFace(tC, unitZ, unitX);

    addScaled(tC.set(center), unitZ, voxelSize*0.5f);
    drawFace(tC, unitY, unitX);

    addScaled(tC.set(center), unitZ, -voxelSize*0.5f);
    drawFace(tC, unitX, unitY);

  }
  
  private PVector tempA  = new PVector();
  private PVector tempB  = new PVector();
  private PVector tempC  = new PVector();
  private PVector tempD  = new PVector();
  void drawFace(PVector center, PVector u, PVector v) {
    
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

    makeRectangle(tempA, tempB, tempC, tempD);    
  }
  
}
