

/**  An utility class for storing a three dimensional vector made from integers instead of floating point numbers.  */  
class Int3 {
  int x = 0;
  int y = 0;
  int z = 0;

  Int3() {
    this(0);
  }

  Int3(int value) {
    this(value, value, value);
  }

  Int3(int x, int y, int z) {
    set(x, y, z);
  }
  
  Int3(PVector v) {
    this(round(v.x), 
         round(v.y), 
         round(v.z));
  }
  










  
  Int3(Int3 i) {
    this(i.x, i.y, i.z);
  }
  

  void set(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void set(Int3 i) {
    set(i.x, i.y, i.z);
  }

  @Override int hashCode() {
    return ((((x * 31) + y) * 31) + z) * 31;     
  }
  
  @Override boolean equals(Object other) {
    if (this == other) return true;
    
    if (other == null) return false;

    if (this.getClass() != other.getClass()) return false;
    
    Int3 otherInt3 = (Int3)other;
    return x == otherInt3.x &&
           y == otherInt3.y &&
           z == otherInt3.z; 
           
  }
   
}

private PVector tempScaled = new PVector();

void addScaled(PVector v, PVector v2, float scale){
  tempScaled.set(v2);
  tempScaled.mult(scale);
  v.add(tempScaled);
}  

void vertex(PVector v){
 vertex(v.x, v.y, v.z);
} 



/** Returns number of seconds since the start of the demo.  */
float secondsFromStart() {
  return (float) tweaker.getTime().getCurrentStepElapsedSeconds();
}


/** Returns number of seconds since the specified time (as returned by secondsFromStart()).  */
float secondsSince(float timeSeconds) {
  return secondsFromStart() - timeSeconds;
}

private PVector u = new PVector();
private PVector v = new PVector();
private PVector t = new PVector(1, 0,0);

private PVector tempR1 = new PVector();
private PVector tempR2 = new PVector();
private PVector dcTempNorm = new PVector();
private PVector tempDir = new PVector();

void drawCylinder(PVector startpos, PVector endpos, float bottomwidth, float topwidth,int sides){
   tempDir.set(0, -1, 0);
   drawCylinder(tempDir, startpos, endpos, bottomwidth, topwidth,sides);
}

void drawCylinder(PVector direction, PVector startpos, PVector endpos, float bottomwidth, float topwidth,int sides){
   
   if (direction.equals(t)){
       t.set(0,0,1);
   }  
   t.cross(direction, u);
   u.cross(direction, v);
   u.normalize();
   v.normalize();
   
   float angle = 0;
   float angleIncrement = TWO_PI / sides;
   beginShape(QUAD_STRIP);
   for (int i = 0; i < sides + 1; ++i) {
     
     // Normal is straight out
     dcTempNorm.set(0,0,0);     
     addScaled(dcTempNorm,u,cos(angle));
     addScaled(dcTempNorm,v,sin(angle));
     normal(dcTempNorm.x, dcTempNorm.y, dcTempNorm.z);
     
     // Bottom pos
     tempR1.set(startpos);
     addScaled(tempR1,u,cos(angle)*bottomwidth);
     addScaled(tempR1,v,sin(angle)*bottomwidth);
     vertex(tempR1);
     
     // Top pos
     tempR2.set(endpos);
     addScaled(tempR2,u,cos(angle)*topwidth);
     addScaled(tempR2,v,sin(angle)*topwidth);
     vertex(tempR2);
     
     angle += angleIncrement;
   }
   endShape();
 }  

void drawTree(PVector startpos, PVector endpos, float bottomwidth, float bottomwidth2, float topwidth,int sides){
   tempDir.set(0, -1, 0);
   drawTree(tempDir, startpos, endpos, bottomwidth, bottomwidth2, topwidth, sides);
}

void drawTree(PVector direction, PVector startpos, PVector endpos, float bottomwidth, float bottomwidth2, float topwidth,int sides){
   
   if (direction.equals(t)){
       t.set(0,0,1);
   }  
   t.cross(direction, u);
   u.cross(direction, v);
   u.normalize();
   v.normalize();
   
   float angle = 0;
   float angleIncrement = TWO_PI / sides;
   beginShape(QUAD_STRIP);
   for (int i = 0; i < sides + 1; ++i) {
     
     // Normal is straight out
     dcTempNorm.set(0,0,0);     
     addScaled(dcTempNorm,u,cos(angle));
     addScaled(dcTempNorm,v,sin(angle));
     normal(dcTempNorm.x, dcTempNorm.y, dcTempNorm.z);
     
     // Bottom pos
     tempR1.set(startpos);
     if (i % 2 == 0) {
       addScaled(tempR1,u,cos(angle)*bottomwidth2);
       addScaled(tempR1,v,sin(angle)*bottomwidth2);
       vertex(tempR1);
     } else {
       addScaled(tempR1,u,cos(angle)*bottomwidth);
       addScaled(tempR1,v,sin(angle)*bottomwidth);
       vertex(tempR1);
     }
     
     // Top pos
     tempR2.set(endpos);
     addScaled(tempR2,u,cos(angle)*topwidth);
     addScaled(tempR2,v,sin(angle)*topwidth);
     vertex(tempR2);
     
     angle += angleIncrement;
   }
   endShape();
 }  

void makeRectangle(PVector a, PVector b, PVector c, PVector d) {
  makeTriangle(a, b, d);  
  makeTriangle(b, c, d);  
}

private PVector mtTempNormal = new PVector();
private PVector mtTempAB = new PVector();
private PVector mtTempAC = new PVector();
void makeTriangle(PVector a, PVector b, PVector c) {
  
  // Calculate normal for triangle
  mtTempAB.set(b).sub(a);
  mtTempAC.set(c).sub(a);
  mtTempAB.cross(mtTempAC, mtTempNormal);
  mtTempNormal.normalize();
  
  // Triangle corners and their normals
  normal(mtTempNormal.x, mtTempNormal.y, mtTempNormal.z);
  vertex(a.x, a.y, a.z);
  vertex(b.x, b.y, b.z);
  vertex(c.x, c.y, c.z);
}



void makeShapeRectangle(PShape shape, PVector a, PVector b, PVector c, PVector d) {
  makeShapeTriangle(shape, a, b, d);  
  makeShapeTriangle(shape, b, c, d);  
}

void makeShapeTriangle(PShape shape, PVector a, PVector b, PVector c) {
  
  // Calculate normal for triangle
  mtTempAB.set(b).sub(a);
  mtTempAC.set(c).sub(a);
  mtTempAB.cross(mtTempAC, mtTempNormal);
  mtTempNormal.normalize();
  
  // Triangle corners and their normals
  shape.normal(mtTempNormal.x, mtTempNormal.y, mtTempNormal.z);
  shape.vertex(a.x, a.y, a.z);
  shape.vertex(b.x, b.y, b.z);
  shape.vertex(c.x, c.y, c.z);
}
