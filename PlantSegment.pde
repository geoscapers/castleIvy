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
 
 /*
 Construction for the root segment, when there is no parentSegment
 */
 PlantSegment(PVector startpos, Ivy plant){
   this.startpos = startpos;
   this.endpos = startpos; 
   this.plant = plant;
   this.startThickness = 0;
   this.endThickness = 0;
   
 }
 
 /*
 Construction for a segment that is not a root (has a parent segment)  
 */
 PlantSegment(PlantSegment parent, Ivy plant){
   this.parent = parent;
   this.startpos = parent.startpos;
   this.endpos = parent.startpos;
   this.plant = plant;
   this.startThickness = parent.endThickness;
   this.endThickness = 0;
   
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
