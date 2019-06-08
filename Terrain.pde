class Terrain {
  
  int size = 100;
  float cellSize = 5;
  float[][] heights = new float[size][size];
  
  Terrain() {
    for(int x = 0; x < size; x++) {
     for (int z = 0; z < size; z++) {
         float pikkukumpare= noise(x * 0.1, z * 0.1) * cellSize * size * 0.05;
         float kumpare = (sin(x / size * PI) * sin(z / size * PI)) * size;
         heights[x][z] = kumpare * 2 + pikkukumpare * 1;
     }
    }
  }
  
  void draw() {
    pushMatrix();
    fill(40, 50, 80);
    translate(-cellSize * size / 2, 50, -cellSize * size / 2);
    
    beginShape(TRIANGLES);
    
    for(int x = 0; x < size - 1; x++) {
     for (int z = 0; z < size - 1; z++) {
         drawCell(x, z);
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
  
  void drawTriangle(float xA, float yA, float zA, float xB, float yB, float zB, float xC, float yC, float zC) {
    vertex(xA, yA, zA);
    vertex(xB, yB, zB);
    vertex(xC, yC, zC);
  
  }
  
}
