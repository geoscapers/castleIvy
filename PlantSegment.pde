class PlantSegment{
  PlantSegment parent;
  PlantSegment nextSegment;
  PlantSegment branchSegment; 
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
 
 
 
 
 
 

}
