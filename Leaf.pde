
class Leaf{
  PlantSegment parentSegment;
  Ivy plant;
  private PVector p1 = new PVector();
  private PVector p2 = new PVector();
  private PVector p3 = new PVector();
  color leafCol;
  
  float leafsize = 0;
  float maxLeafsize = 1;
  float leafBirthSecondFromStart;
  
  Leaf(Ivy plant, PlantSegment parentSegment){
    this.plant = plant;
    this.parentSegment = parentSegment;
    leafBirthSecondFromStart = secondsFromStart();
    leafCol = color(hue(plant.leafColor+(int)(random(-10, 10))), saturation(plant.leafColor)+(int)(random(-10, 10)), brightness(plant.leafColor)+(int)(random(-10, 10)));
    
  }
  
  
  void updateLeaf(){
      //do all of the updating of the leaf here
      leafsize += plant.leafGrowthSpeed;
      if (leafsize > maxLeafsize) leafsize = maxLeafsize;
  }
  
  void drawLeaf(){
     float colorage = secondsSince(leafBirthSecondFromStart)*plant.leafColorChangeRate;
     if (colorage > 1) colorage = 1;
     fill(lerpColor(plant.sproutColor, leafCol, colorage));
     //do the drawing of the leaf here
     pushMatrix();
     
     translate(parentSegment.endpos.x,parentSegment.endpos.y, parentSegment.endpos.z);
     plant.rnd.setSeed(parentSegment.segmentcount+plant.ivyseed);
     rotateX(TAU*(0.25));
     
     rotateZ(plant.rnd.nextFloat(TAU));
     rotateX(-TAU*(plant.rnd.nextFloat(0.0, 0.1)));
     translate(0, -parentSegment.endThickness, 0);
     scale(leafsize);
     drawPart();
     
     popMatrix();
  } 
  private PVector tNormal = new PVector();
  
  public void addTriangle(PVector p1, PVector p2, PVector p3) {
  faceNormal(p1, p2, p3, tNormal);
  normal(tNormal.x, tNormal.y, tNormal.z);
  vertex(p1);
  vertex(p2);
  vertex(p3);
}

private PVector t1 = new PVector();
private PVector t2 = new PVector();
  PVector faceNormal(PVector p1, PVector p2, PVector p3, PVector normall) {
    t1.set(p1);
    t1.sub(p2);
    
    t2.set(p1);
    t2.sub(p3);
  
    t1.cross(t2, normall);
    return normall;
  }
  
  void drawPart() {
    int leafSegments = 6;
    float leafLength = 0.95;
    float leafWidth = 0.6;
    
    float upTilt = 0.25;

     
    noStroke();
    
    beginShape(TRIANGLES);
    
    for (int i = 0; i < leafSegments; i++) {
      float relPos = map(i, 0, leafSegments, 0f, 1f);
      float nextRelPos = map(i + 1, 0, leafSegments, 0f, 1f);
      
      leafEdgePoint(relPos, 0.5*leafWidth, leafLength, upTilt, p1);  
      leafCenterPoint(relPos, leafLength, p2);
      leafCenterPoint(nextRelPos, leafLength, p3);
      addTriangle(p1, p2, p3);

      leafCenterPoint(nextRelPos, leafLength, p1);
      leafEdgePoint(nextRelPos, 0.5*leafWidth, leafLength, upTilt, p2);  
      leafEdgePoint(relPos, 0.5*leafWidth, leafLength, upTilt, p3);  
      addTriangle(p1, p2, p3);
      
      leafCenterPoint(relPos, leafLength, p1);
      leafEdgePoint(relPos, -0.5*leafWidth, leafLength, upTilt, p2);  
      leafCenterPoint(nextRelPos, leafLength, p3);
      addTriangle(p1, p2, p3);

      leafEdgePoint(nextRelPos, -0.5*leafWidth, leafLength, upTilt, p1);  
      leafCenterPoint(nextRelPos, leafLength, p2);
      leafEdgePoint(relPos, -0.5*leafWidth, leafLength, upTilt, p3);  
      addTriangle(p1, p2, p3);
      
    }
    
    endShape();

  }
  
    float mapClamp(float value, float sourceStart, float sourceEnd, float destStart, float destEnd) {
  return map(constrain(value, sourceStart, sourceEnd), sourceStart, sourceEnd, destStart, destEnd);
  
}
  
  void leafCenterPoint(float relPos, float leafLen, PVector pos) {
      float y = mix(relPos, 0, -leafLen);
      pos.x = 0;
      pos.y = y;
      pos.z = 0;
  }
  
  float mix(float t, float a, float b) {
  return (b - a) * t + a;
}
  
  void leafEdgePoint(float relPos, float leafR, float leafLen, float upTilt, PVector pos) {
       float cutoverPoint = 0.8;
      float baseW = pow(mapClamp(relPos, 0, cutoverPoint, 0, 1), 0.5);
      float tipW = 0.5*(1+cos(TAU*mapClamp(relPos, cutoverPoint, 1, 0, 1)*0.5));
      float w = mix(relPos, baseW, tipW);
      
      float x = 0.5*leafR * w;
      float z = 0 + upTilt * abs(leafR) * sin(0.5*TAU*min(relPos, 1-relPos));
      float y = mix(relPos, 0, -leafLen);
      
      pos.x = x;
      pos.y = y;
      pos.z = z;
 }
  
}

 
