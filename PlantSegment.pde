class PlantSegment{
  PlantSegment parent;
  PlantSegment nextSegment;
  PlantSegment branchSegment; 
  Leaf leaf;
  Ivy plant;
  float startX;
  float startY; 
  float startZ;
  float endX;
  float endY;
  float endZ;
  float startTickness;
  float endThickness;
 

 PlantSegment(float startx, float starty, float startz, Ivy plant){
   this.startX = startx;
   this.endX = startx;
   this.startY = starty;
   this.endY = starty;
   this.startZ = startz;
   this.endZ = startz; 
   this.plant = plant;
 }
 
 PlantSegment(PlantSegment parent, Ivy plant){
   this.parent = parent;
   this.startX = parent.startX;
   this.endX = parent.startX;
   this.startY = parent.startY;
   this.endY = parent.startY;
   this.startZ = parent.startZ;
   this.endZ = parent.startZ; 
   this.plant = plant;
 }  
 
 void update(){
   //add here code for updating this segment
   
   
   // then update all the leaf of this branch and the next segments if they are not null
   if (leaf != null) leaf.updateLeaf();
   if (nextSegment != null) nextSegment.update();  
   if (branchSegment != null) branchSegment.update();  
 }
 void drawSegment(){
   //do the drawing of this segment here
   
   //then draw the next segments
   if (leaf != null) leaf.drawLeaf();
   if (nextSegment != null) nextSegment.drawSegment();  
   if (branchSegment != null) branchSegment.drawSegment();  
   
 }  
 
 
 
 

}
