

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


private PVector tempV1 = new PVector();
private PVector tempV2 = new PVector();
private PVector tempV3 = new PVector();
private PVector tempVn = new PVector();

/** Creates and adds a normal for a specified triangle */
void triangleNormal(float x1, float y1, float z1, 
                    float x2, float y2, float z2,
                    float x3, float y3, float z3) {
                      
    tempV1.set(x1, y1, z1);
    tempV2.set(x2, y2, z2);
    tempV3.set(x3, y3, z3);
    
  //  tempV1.cross(,,)
}
