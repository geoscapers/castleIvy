class Terrain {
  
  int size = 100;
  float cellSize = 5;
  float[][] heights = new float[size][size];
  
  Terrain() {
    for(int x = 0; x < size - 1; x++) {
     for (int y = 0; y < size - 1; y++) {
         heights[x][y] = noise(x, y) * cellSize * size * 0.05;
     }
    }
  }
  
  void draw() {
    beginShape(TRIANGLES);
    
    for(int x = 0; x < size - 1; x++) {
     for (int y = 0; y < size - 1; y++) {
         drawCell(x, y);
     }
    }
    
    endShape();
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
    drawTriangle(x2, y2, z1, x2, y4, z2, x1, y3, y2);
  }
  
  void drawTriangle(float xA, float yA, float zA, float xB, float yB, float zB, float xC, float yC, float zC) {
    vertex(xA, yA, zA);
    vertex(xB, yB, zB);
    vertex(xC, yC, zC);
    fill(150);
  
  }
  
}
