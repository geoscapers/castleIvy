
class Terrain {
  
  int size;
  float cellSize;
  float[][] heights;
  PVector start;
  PVector end;
  float kumpareDepth;
  float kumparePIsiirto;
  float kumpareKorkeus;
  float surfaceRandomization;
  boolean showGrass;
  
  PShape terrainShape;
  
  Terrain(float cellSize, float kumpareDepth, float kumparePIsiirto, float kumpareKorkeus, float surfaceRandomization, boolean showGrass) {
    
    this.size = 30;
    this.cellSize = cellSize;
    this.kumpareDepth = kumpareDepth;
    this.kumparePIsiirto = kumparePIsiirto;
    this.end = new PVector();
    this.start = new PVector();
    this.heights = new float[size][size];
    this.kumpareKorkeus = kumpareKorkeus;
    this.surfaceRandomization = surfaceRandomization;
    this.showGrass = showGrass;
    
    this.terrainShape = createShape();
    
    for(int x = 0; x < size; x++) {
     for (int z = 0; z < size; z++) {
         float pikkukumpare= noise(x * 0.1 + surfaceRandomization * 234.982, z * 0.1 + surfaceRandomization * 123.123) * cellSize * size * 0.05;
         float worldX = x * cellSize - size / 2 * cellSize;
         float worldZ = z * cellSize - size / 2 * cellSize;
         float distance = sqrt(worldX * worldX + worldZ * worldZ);
         float kumpare = sin(distance * kumpareDepth * PI + kumparePIsiirto * PI);
         
         heights[x][z] = kumpare * kumpareKorkeus + pikkukumpare * -4;
     }
    }
  }
  
  void draw() {
    pushMatrix();
    fill(29, 50, 65);
    translate(-cellSize * size / 2, 58, -cellSize * size / 2);
    
    beginShape(TRIANGLES);
    
    for(int x = 0; x < size - 1; x++) {
     for (int z = 0; z < size - 1; z++) {
         drawCell(x, z);
     }
    }
    
    endShape();

    for(int x = 0; x < size - 1; x++) {
     for (int z = 0; z < size - 1; z++) {
       if (showGrass == true) {
         float dX = x - size / 2;
         float dZ = z - size / 2;
         float centerDistance = sqrt(dX * dX + dZ * dZ);
         float grassAmount = max(0, map(centerDistance, 0, size / 2.8, 20, 0));
         drawItems(x, z, (int) grassAmount, cellSize * 0.2);
       } else {
         drawItems(x, z, 2, cellSize * 0.8); 
       }    
     }
    }
   
    popMatrix();
  }
  
  void drawCell(int cellX, int cellZ) {
    float y1 = heights[cellX][cellZ];
    float y2 = heights[cellX + 1][cellZ];
    float y3 = heights[cellX][cellZ + 1];
    float y4 = heights[cellX+1][cellZ + 1];
    
    float x1 = cellSize * cellX;
    float x2 = cellSize * (cellX + 1);
    
    float z1 = cellSize * cellZ;
    float z2 = cellSize * (cellZ + 1); 
    
    drawTriangle(x1, y1, z1, x2, y2, z1, x1, y3, z2, cellX, cellZ, cellX + 1, cellZ, cellX, cellZ + 1);
    drawTriangle(x2, y2, z1, x2, y4, z2, x1, y3, z2, cellX + 1, cellZ, cellX + 1, cellZ + 1, cellX, cellZ + 1);
   
    
  }
  
  void drawItems(int cellX, int cellZ, int itemAmount, float shuffle) {
    
    strokeWeight(2);

    for (int x = 0; x < itemAmount; x++) {
      
      for (int z = 0; z < itemAmount; z++) {
        
        float dX = x * 1f / itemAmount * cellSize;
        float dZ = z * 1f / itemAmount * cellSize;
        
        float gX = cellX * cellSize + dX;
        float gZ = cellZ * cellSize + dZ;
        
        float tX = map(noise(gX, gZ), 0, 1, -shuffle, shuffle);
        float tZ = map(noise(gX + 113.35, gZ + 142.93), 0, 1, -shuffle, shuffle);
        
        gX += tX;
        gZ += tZ;
        
        float y1 = heights[cellX][cellZ];
        float y2 = heights[cellX + 1][cellZ];
        float y3 = heights[cellX][cellZ + 1];
        float y4 = heights[cellX + 1][cellZ + 1];
        
        float yA = map(x, 0, itemAmount, y1, y2);
        float yB = map(x, 0, itemAmount, y3, y4);
        float yC = map(z, 0, itemAmount, yA, yB);
        
        float windSpeed = 0.25;
        float windAmount = cellSize * 0.2;
        float wX = map(noise(secondsFromStart() * windSpeed + gX * 2.437 + gZ * 2.56), 0, 1, -windAmount, windAmount);
        float wZ = map(noise(secondsFromStart() * windSpeed + 9.4992 + gZ * 3.154  + gX * 4.65), 0, 1, -windAmount, windAmount);
        
        if (showGrass == true) {
          beginShape(LINES);
          
          stroke(28, 50, 30);
          vertex(gX, yC, gZ);
          stroke(28, 50, 50);
          vertex(gX + wX, yC - 2, gZ + wZ);
          
          endShape();
        } else {
          beginShape(TRIANGLES);
          
          noStroke();
        
          start.set(gX, yC + 0.1, gZ);
          end.set(gX, yC - 8, gZ);
         
          drawTree(start, end, 3, 1, 0.1, 20);
          endShape();
        }
      } 
    }
  }
  
  void calculateNormal(int x, int z) {
    if (x <= 0 || x >= size - 1 ||
        z <= 0 || z >= size - 1) {
       normal(0, -1, 0);
       return;
    }
    
   float yx1 = heights[x-1][z];
   float yx2 = heights[x+1][z];
   
   float yz1 = heights[x][z-1];
   float yz2 = heights[x][z+1];
   
   tempVn.x = yx2 - yx1;
   tempVn.y = -cellSize * 2;
   tempVn.z = yz2 - yz1;
   
   tempVn.normalize();
   
   normal(tempVn.x, tempVn.y, tempVn.z);
  }

  
  void drawTriangle(float xA, float yA, float zA, float xB, float yB, float zB, float xC, float yC, float zC, 
                    int cellXA, int cellZA, int cellXB, int cellZB, int cellXC, int cellZC) {
    noStroke();
    
    tempV1.set(xB - xA, yB - yA, zB - zA);
    tempV2.set(xC - xA, yC - yA, zC - zA);
     
    calculateNormal(cellXA, cellZA);
    vertex(xA, yA, zA);
    
    calculateNormal(cellXB, cellZB);
    vertex(xB, yB, zB);
    
    calculateNormal(cellXC, cellZC);
    vertex(xC, yC, zC);
  }
}

PVector tempV1 = new PVector();
PVector tempV2 = new PVector();
PVector tempVn = new PVector();
