

/** Actually, we need a voxelengine too!  Lets keep it simple with one chunk and limited world size.  */
class Voxels {
  
  int countX;
  int countY;
  int countZ;

  byte voxels[][][];
  
  color blockColors[];
  
  float voxelSize = 0.25f;
  
  PVector position = new PVector();
  
  private PVector tempCenter = new PVector();
  
  Voxels(float voxelSize, int countX, int countY, int countZ) {
    this.voxelSize = voxelSize;
    this.countX = countX;
    this.countY = countY;
    this.countZ = countZ;
  
    initBlockColors();
  
    // Center x and z
    position.set(-countX * voxelSize / 2f, 0, -countX * voxelSize / 2f);
    
    // Allocate the matixes!
    voxels = new byte[countX][countY][countZ];
  }

  void initBlockColors() {
    // These need to multiply up to 255
    int hueCount = 8;
    int satCount = 4;
    int lumCount = 8;
    
    // Palette with hues with various saturations and brightness runs
    int colorIndex = 0;
    for (int hue = 0; hue < hueCount; hue++) {
      for (int sat = 0; sat < satCount; sat++) {
        for (int lum = 0; lum < lumCount; lum++) {
          blockColors[colorIndex++] = color((hue+1) * 100/hueCount, 
                                            (sat+1) * 100/satCount, 
                                            (lum+1) * 100/lumCount);
        }
      }
    }
    
    // Note: index 0 is reseved for air, so darkest greyest red can't be used.  Too bad.
  }
  
  void draw() {
    pushMatrix();
    beginShape(TRIANGLES);
    
    float xPos = 0f;
    float yPos = 0f;
    float zPos = 0f;
    
    for (int z = 0; z < countX; z++) {
      zPos = z * voxelSize;
      for (int y = 0; y < countX; y++) {
        yPos = y * voxelSize;
        for (int x = 0; x < countX; x++) {
          xPos = x * voxelSize;
          
          int voxelType = voxels[x][y][z];
          
          if (voxelType != 0) {                          
            tempCenter.set(xPos + voxelSize * 0.5f, 
                           yPos + voxelSize * 0.5f, 
                           zPos + voxelSize * 0.5f);
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
    
    addScaled(tC.set(center), unitX, voxelSize);
    drawFace(tC, unitY, unitZ);

    addScaled(tC.set(center), unitX, -voxelSize);
    drawFace(tC, unitZ, unitY);

    addScaled(tC.set(center), unitY, voxelSize);
    drawFace(tC, unitX, unitZ);

    addScaled(tC.set(center), unitY, -voxelSize);
    drawFace(tC, unitZ, unitX);

    addScaled(tC.set(center), unitZ, voxelSize);
    drawFace(tC, unitY, unitX);

    addScaled(tC.set(center), unitZ, -voxelSize);
    drawFace(tC, unitX, unitY);

  }
  
  private 
  void drawFace(PVector center, PVector u, PVector v) {
    
    makeRectangle
    
  }
  
}
