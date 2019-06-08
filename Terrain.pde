class Terrain {
  
  int size = 30;
  float cellSize = 5;
  float[][] heights = new float[size][size];
  
  Terrain() {
    for(int x = 0; x < size; x++) {
     for (int z = 0; z < size; z++) {
         float pikkukumpare= noise(x * 0.1, z * 0.1) * cellSize * size * 0.05;
         float kumpare = (sin(x / size * PI) * sin(z / size * PI)) * size;
         heights[x][z] = kumpare * 13 + pikkukumpare * 4;
     }
    }
  }
  
  void draw() {
    pushMatrix();
    fill(25, 55, 80);
    translate(-cellSize * size / 2, -10, -cellSize * size / 2);
    
    beginShape(TRIANGLES);
    
    for(int x = 0; x < size - 1; x++) {
     for (int z = 0; z < size - 1; z++) {
         drawCell(x, z);
     }
    }
    
    endShape();

    
    beginShape(LINES);
    
    for(int x = 0; x < size - 1; x++) {
     for (int z = 0; z < size - 1; z++) {
         drawGrass(x, z);
     }
    }
    endShape();
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
    
    drawTriangle(x1, y1, z1, x2, y2, z1, x1, y3, z2);
    drawTriangle(x2, y2, z1, x2, y4, z2, x1, y3, z2);
  }
  
  void drawGrass(int cellX, int cellZ) {
    
    strokeWeight(2);
    
    int grassAmount = 5;
    for (int x = 0; x < grassAmount; x++) {
      
      for (int z = 0; z < grassAmount; z++) {
        
        
        
        float dX = x * 1f / grassAmount * cellSize;
        
        
        float dZ = z * 1f / grassAmount * cellSize;
        
        float gX = cellX * cellSize + dX;
        float gZ = cellZ * cellSize + dZ;
        
        float shuffle = cellSize * 0.2;
        float tX = map(noise(gX, gZ), 0, 1, -shuffle, shuffle);
        float tZ = map(noise(gX + 113.35, gZ + 142.93), 0, 1, -shuffle, shuffle);
        
        gX += tX;
        gZ += tZ;
        
        float y1 = heights[cellX][cellZ];
        float y2 = heights[cellX + 1][cellZ];
        float y3 = heights[cellX][cellZ + 1];
        float y4 = heights[cellX + 1][cellZ + 1];
        
        float yA = map(x, 0, grassAmount, y1, y2);
        float yB = map(x, 0, grassAmount, y3, y4);
        float yC = map(z, 0, grassAmount, yA, yB);
        
        float windSpeed = 0.25;
        float windAmount = cellSize * 0.4;
        float wX = map(noise(secondsFromStart() * windSpeed + gX * 437), 0, 1, -windAmount, windAmount);
        float wZ = map(noise(secondsFromStart() * windSpeed + 949.92 + gZ * 154), 0, 1, -windAmount, windAmount);
        
        stroke(30, 60, 40);
        vertex(gX, yC, gZ);
        stroke(30, 60, 70);
        vertex(gX + wX, yC - 4, gZ + wZ);

      }
      
    }
    
  }
  
  void drawTriangle(float xA, float yA, float zA, float xB, float yB, float zB, float xC, float yC, float zC) {
    noStroke();
    tempV1.set(xB - xA, yB - yA, zB - zA);
    tempV2.set(xC - xA, yC - yA, zC - zA);
    
    PVector.cross(tempV1, tempV2, tempVn);
    tempVn.normalize();
    
    
    vertex(xA, yA, zA);
    normal(tempVn.x, tempVn.y, tempVn.z);
    vertex(xB, yB, zB);
    normal(tempVn.x, tempVn.y, tempVn.z);
    vertex(xC, yC, zC);
    normal(tempVn.x, tempVn.y, tempVn.z);
  }
}

PVector tempV1 = new PVector();
PVector tempV2 = new PVector();
PVector tempVn = new PVector();
