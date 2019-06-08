class Terrain {
  
  int size = 100;
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
    
    strokeWeight(0.15);
    
    int grassAmount = 10;
    for (int x = 0; x < grassAmount; x++) {
      
      for (int z = 0; z < grassAmount; z++) {
        
        float dX = x * 1f / grassAmount * cellSize;
        dX += noise(x * 0.5, z * 0.5);
        
        float dZ = z * 1f / grassAmount * cellSize;
        dZ += noise(x * 0.5, z * 0.5);
        
        float y1 = heights[cellX][cellZ];
        float y2 = heights[cellX + 1][cellZ];
        float y3 = heights[cellX][cellZ + 1];
        float y4 = heights[cellX + 1][cellZ + 1];
        
        float yA = map(x, 0, grassAmount, y1, y2);
        float yB = map(x, 0, grassAmount, y3, y4);
        float yC = map(z, 0, grassAmount, yA, yB);
        
        
        
        stroke(30, 60, 40);
        vertex(cellX * cellSize + dX, yC, cellZ * cellSize + dZ);
        stroke(30, 60, 70);
        vertex(cellX * cellSize + dX, yC - 5, cellZ * cellSize + dZ);
      }
      
    }
    
  }
  
  void drawTriangle(float xA, float yA, float zA, float xB, float yB, float zB, float xC, float yC, float zC) {
    
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
  
  void updateGrass() {
  }
}

PVector tempV1 = new PVector();
PVector tempV2 = new PVector();
PVector tempVn = new PVector();
