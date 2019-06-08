

void getCastleDistance(PVector position, PVector vectorToClosestWall) {
  
  float centerX = 0;
  float centerZ = 0;
  float radius = 3;
  
  vectorToClosestWall.set(
    centerX - position.x,
    0,
    centerZ - position.z);
}




class Castle {
  HashMap<Int3, Cell> cells = new HashMap();

  float cellWidth = 3f;
  float cellHeight = 4f;
  float wallThickness = cellWidth * 0.15;
  float wallOverlap = wallThickness * 0.5;
  
  color col = color(random(70, 90), random(5, 30), random(20, 40));
  
  PVector pos = new PVector();
  
  XoroShiro random = new XoroShiro(422);
  
  Castle() {
    generate();
  }
  
  Cell getOrCreateCell(Int3 location) {
    Cell c = cells.get(location);
    if (c == null) {
      c = new Cell(this, location);
      cells.put(c.location, c);
    }
    
    return c;
  }
  
  void generate() {
    Int3 loc = new Int3();
    int numChambers = 100;
    int radius = 4;
    for (int i = 0; i < numChambers; i++) {
      loc.x = (int) random(-radius, radius);
      loc.y = (int) random(-radius, radius);
      loc.z = (int) random(-radius, radius);
      Cell cell = getOrCreateCell(loc);
      cell.westWall = random(0, 1) < 0.4f ? true : false;
      cell.northWall = random(0, 1) < 0.4f ? true : false;
      cell.roof = random(0, 1) < 0.8f ? true : false;      
    }
  }

  void draw() {
    noStroke();
    pushMatrix();
    
    for (Cell cell: cells.values()) {
      cell.draw();
    }
    
    popMatrix();
  }
  
}


class Cell {
  Int3 location = new Int3();
  Castle castle;
  color col;  
  
  boolean westWall = true;
  boolean northWall = true;
  boolean roof = true;
  
  Cell(Castle castle, Int3 location) {
    this.castle = castle;
    this.location.set(location);
    col = castle.col;
  }
  
  void draw() {
    
    float x = castle.pos.x + location.x * castle.cellWidth;
    float y = castle.pos.y + location.y * castle.cellHeight;
    float z = castle.pos.z + location.z * castle.cellWidth;
    
    float w = castle.cellWidth;
    float h = castle.cellHeight;
    float t = castle.wallThickness;
    float overlap = castle.wallOverlap;
    
    if (westWall) {
      drawBlock(col, 
                x, y + h * 0.5, z + w * 0.5,
                t, h + overlap, w + overlap);
    }
    
    if (northWall) {
      drawBlock(col, 
                x + w * 0.5, y + h * 0.5, z,
                w + overlap, h + overlap, t);
    }
    
    if (roof) {
      drawBlock(col, 
                x + w * 0.5, y - h, z + w * 0.5,
                w + overlap, t, w + overlap);
    }    
  }

  void drawBlock(color col, float cx, float cy, float cz, float sx, float sy, float sz) {
    translate(cx, cy, cz);
    fill(col);
    box(sx, sy, sz);
    
    sphereDetail(6, 5);
    castle.random.setSeed(location.x, location.y, location.z);    
    for (int i = 0; i < 30; i++) {

      
      fill(hue(col) + castle.random.nextFloat(-5, 5), 
           saturation(col) + castle.random.nextFloat(-10, 10), 
           brightness(col) + castle.random.nextFloat(-15, 15));
      
      float dx = castle.random.nextFloat(-sx/2, sx/2);
      float dy = castle.random.nextFloat(-sy/2, sy/2);
      float dz = castle.random.nextFloat(-sz/2, sz/2);
      float r = max(sx, sy, sz) * castle.random.nextFloat(0.08f, 0.14f);
      pushMatrix();
      translate(dx, dy, dz);
      float scaling = 0.5;
      scale(1f + castle.random.nextFloat(-scaling, scaling),
            1f + castle.random.nextFloat(-scaling, scaling),
            1f + castle.random.nextFloat(-scaling, scaling));
      rotateX(castle.random.nextFloat(0, TAU));
      rotateY(castle.random.nextFloat(0, TAU));
      rotateZ(castle.random.nextFloat(0, TAU));
      sphere(r);
      //translate(-dx, -dy, -dz);
      popMatrix();
    }
    
    translate(-cx, -cy, -cz);  
  }
}
