class PlantSegment{
  PlantSegment parent;
  PlantSegment nextSegment;
  PlantSegment branchSegment; 
  Leaf leaf;
  Ivy plant;
  PVector startpos;
  PVector endpos;
  float startThickness;
  float endThickness;
  PVector direction;
  float segmentLength; 
 
 /*
 Construction for the root segment, when there is no parentSegment
 */
 PlantSegment(PVector startpos, Ivy plant){
   this.startpos.set(startpos);
   this.endpos.set(startpos); 
   this.plant = plant;
   this.startThickness = 0;
   this.endThickness = 0;
   this.direction.set(plant.upDirection);
   direction.normalize();
   this.segmentLength = 0;
   
   
 }
 
 /*
 Construction for a segment that is not a root (has a parent segment)  
 */
 PlantSegment(PlantSegment parent, Ivy plant){
   this.parent = parent;
   this.startpos.set(parent.startpos);
   this.endpos.set(parent.startpos);
   this.plant = plant;
   this.startThickness = parent.endThickness;
   this.endThickness = 0;
   this.direction.set(parent.direction);
   direction.normalize();
   this.segmentLength = 0;
   
 }  
 
 void update(){
   //add here code for updating this segment
   //if the previous segment have changed it's endpos then update our startpos
   boolean startposChanged = false;
   if (parent != null && parent.endpos != startpos){
       startpos.set(parent.endpos);  
       startposChanged = false;
       
   }
   // if we can still grow then grow it with the growthSpeed
   boolean segmentGrown = false;
   if (segmentLength < plant.maxSegmentLenght){
     segmentGrown = true;
     //TODO add seconds to the growing
     segmentLength += plant.growthSpeed;
     if (segmentLength > plant.maxSegmentLenght) segmentLength = plant.maxSegmentLenght;
   }  
   //if the startpos changed or the plant was grown then endpos needs to be changed as well
   if (startposChanged || segmentGrown) {
       endpos.set(direction);
       endpos.mult(segmentLength);
       endpos.add(startpos);
   }  
   
   
   // then update all the leaf of this branch and the next segments if they are not null
   if (leaf != null) leaf.updateLeaf();
   if (nextSegment != null) nextSegment.update();  
   if (branchSegment != null) branchSegment.update();  
 }
 void drawSegment(){
   //do the drawing of this segment here
   drawCylinder(0, 10, 10, 10);
   
   //then draw the next segments
   if (leaf != null) leaf.drawLeaf();
   if (nextSegment != null) nextSegment.drawSegment();  
   if (branchSegment != null) branchSegment.drawSegment();  
   
 }  
 
 void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();
  
 }
 
 
 
 

}
