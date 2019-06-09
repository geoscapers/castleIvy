
class Leaf{
  PlantSegment parentSegment;
  Ivy plant;
  
  color leafCol;
  color autumCol;
  color currentSummerColor;
  
  float leafsize = 0;
  float maxLeafsize = 1;
  float leafBirthSecondFromStart;
  PVector randomDirection;
  
  Leaf(Ivy plant, PlantSegment parentSegment){
    this.plant = plant;
    this.parentSegment = parentSegment;
    leafBirthSecondFromStart = secondsFromStart();
    leafCol = color(hue(plant.leafColor+(int)(random(-10, 10))), saturation(plant.leafColor)+(int)(random(-10, 10)), brightness(plant.leafColor)+(int)(random(-10, 10)));
    autumCol = color(hue(plant.leafColorAutum +(int)(random(-10, 10))), saturation(plant.leafColorAutum )+(int)(random(-25, 15)), brightness(plant.leafColorAutum )+(int)(random(-15, 15)));
    currentSummerColor = leafCol;
    randomDirection = new PVector(random(0, 3), random(-0.5, 1), random(-1, 1));
}
  
  
  void updateLeaf(){
      //do all of the updating of the leaf here
      leafsize += plant.leafGrowthSpeed*plant.secondFromPreviousUpdate;
      if (leafsize > maxLeafsize) leafsize = maxLeafsize;
  }
  
  void drawLeaf(){
    plant.rnd.setSeed(parentSegment.segmentcount+plant.ivyseed);
     //when no autum is near all is green
    if (plant.atumness == 0){
       float colorage = secondsSince(leafBirthSecondFromStart)*plant.leafColorChangeRate;
       if (colorage > 1) colorage = 1;
       currentSummerColor = lerpColor(plant.sproutColor, leafCol, colorage);
       fill(currentSummerColor);
    }
    //when autum starts
     else {
        fill(lerpColor(currentSummerColor, autumCol, plant.atumness));
     }  
    if (!plant.leafGoBoom){
        
     //do the drawing of the leaf here
     pushMatrix();
     
     translate(parentSegment.endpos.x,parentSegment.endpos.y, parentSegment.endpos.z);
     
     rotateX(TAU*(0.25));
     
     rotateZ(plant.rnd.nextFloat(TAU));
     rotateX(-TAU*(plant.rnd.nextFloat(0.0, 0.1))+(plant.atumness*TAU*0.15));
     translate(0, -parentSegment.endThickness, 0);
     scale(leafsize);
     drawPart();
     
     popMatrix();
    } 
    //when the leaf go boom
    else{
     pushMatrix();
     
     translate(
         parentSegment.endpos.x+(randomDirection.x*secondsSince(plant.timeOfBoom)*plant.boomspeed),
         parentSegment.endpos.y+(randomDirection.y*secondsSince(plant.timeOfBoom)*plant.boomspeed), 
         parentSegment.endpos.z+(randomDirection.z*secondsSince(plant.timeOfBoom)*plant.boomspeed));
     plant.rnd.setSeed(parentSegment.segmentcount+plant.ivyseed);
     rotateX(TAU*(0.25)+secondsSince(plant.timeOfBoom)*plant.rnd.nextFloat(0.9, 4));
     
     rotateZ(plant.rnd.nextFloat(TAU)+secondsSince(plant.timeOfBoom)*plant.rnd.nextFloat(0.5, 3));
     rotateY(secondsSince(plant.timeOfBoom)*plant.rnd.nextFloat(1, 2));
     
    
     scale(leafsize);
     drawPart();
     
     popMatrix();
    }  
  } 
  
  
  public void addTriangle(PVector p1, PVector p2, PVector p3) {
  faceNormal(p1, p2, p3, plant.tNormal);
  normal(plant.tNormal.x, plant.tNormal.y, plant.tNormal.z);
  vertex(p1);
  vertex(p2);
  vertex(p3);
}


  PVector faceNormal(PVector p1, PVector p2, PVector p3, PVector normall) {
    plant.t1.set(p1);
    plant.t1.sub(p2);
    
    plant.t2.set(p1);
    plant.t2.sub(p3);
  
    plant.t1.cross(plant.t2, normall);
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
      
      leafEdgePoint(relPos, 0.5*leafWidth, leafLength, upTilt, plant.p1);  
      leafCenterPoint(relPos, leafLength, plant.p2);
      leafCenterPoint(nextRelPos, leafLength, plant.p3);
      addTriangle(plant.p1, plant.p2, plant.p3);

      leafCenterPoint(nextRelPos, leafLength, plant.p1);
      leafEdgePoint(nextRelPos, 0.5*leafWidth, leafLength, upTilt, plant.p2);  
      leafEdgePoint(relPos, 0.5*leafWidth, leafLength, upTilt, plant.p3);  
      addTriangle(plant.p1, plant.p2, plant.p3);
      
      leafCenterPoint(relPos, leafLength, plant.p1);
      leafEdgePoint(relPos, -0.5*leafWidth, leafLength, upTilt, plant.p2);  
      leafCenterPoint(nextRelPos, leafLength, plant.p3);
      addTriangle(plant.p1, plant.p2, plant.p3);

      leafEdgePoint(nextRelPos, -0.5*leafWidth, leafLength, upTilt, plant.p1);  
      leafCenterPoint(nextRelPos, leafLength, plant.p2);
      leafEdgePoint(relPos, -0.5*leafWidth, leafLength, upTilt, plant.p3);  
      addTriangle(plant.p1, plant.p2, plant.p3);
      
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

 
