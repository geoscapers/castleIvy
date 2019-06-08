class PlantSegment{
  PlantSegment parent;
  PlantSegment nextSegment;
  PlantSegment branchSegment; 
  Leaf leaf;
  Ivy plant;
  PVector startpos = new PVector();
  PVector endpos = new PVector();
  float startThickness;
  float endThickness;
  PVector direction = new PVector();
  float segmentLength; 
  //count from bottom
  int segmentcount;
  boolean branchTried = false;
  float noiseseed = 0;
  float branchProbability = 0;
  boolean branchEnding = false;
  
 
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
   plant.addSegmentAmount();
   segmentcount = 1;
   noiseseed = 0;
   branchProbability = plant.branchProbability;
   
   
 }
 
 /*
 Construction for a segment that is not a root (has a parent segment)  
 and are not given its direction
 */
 PlantSegment(PlantSegment parent, Ivy plant){
   
   this.parent = parent;
   this.noiseseed = parent.noiseseed;
   this.startpos.set(parent.endpos);
   this.endpos.set(parent.endpos);
   this.plant = plant;
   this.startThickness = parent.endThickness;
   this.endThickness = 0;
   segmentcount = parent.segmentcount +1;
   float noisepos = segmentcount/2f;
   this.direction.set(parent.direction);
   direction.normalize();
   branchProbability = parent.branchProbability;
  
   this.direction.add(
       map(noise(noiseseed+noisepos+113.13), 0, 1, -plant.turnstrength, plant.turnstrength), 
       map(noise(noiseseed+noisepos+231.12), 0, 1, -plant.turnstrength, plant.turnstrength), 
       map(noise(noiseseed+noisepos+21.21), 0, 1, -plant.turnstrength, plant.turnstrength));
   direction.add(plant.upDirection.x*0.07, plant.upDirection.y*0.07, plant.upDirection.z*0.07);   
   direction.normalize();
   this.segmentLength = 0;
   plant.addSegmentAmount();
   
   
 }  
 
  /*
 Construction for a segment that is not a root (has a parent segment)  
 and are not given its direction
 */
 PlantSegment(PlantSegment parent, Ivy plant, PVector direction){
   this.parent = parent;
   this.startpos.set(parent.endpos);
   this.endpos.set(parent.endpos);
   this.plant = plant;
   this.startThickness = parent.endThickness;
   this.endThickness = 0;
   this.direction.set(direction);
   direction.normalize();
   this.segmentLength = 0;
   this.noiseseed = random(0f, 100f);
   plant.addSegmentAmount();
   segmentcount = parent.segmentcount +1;
   branchProbability = 0.2*parent.branchProbability;
   
 } 
 
 void update(){
   //add here code for updating this segment
   //thickness
   if (parent != null){
     startThickness = parent.endThickness;
     
     endThickness = startThickness*0.97;
     //if no branch end in a tip
     if (nextSegment == null && branchSegment == null){
       endThickness = 0;
     } 
     //othervise put a minimum width
     else{
       if (endThickness < 0.005)endThickness = 0.005;
     }  
   }
   else{
     endThickness = startThickness*0.97;
   }
   
   
   //if the previous segment have changed it's endpos then update our startpos
   boolean startposChanged = false;
   if (parent != null && !parent.endpos.equals(startpos)){
       startpos.set(parent.endpos);  
       startposChanged = false;
       
       
   }
   // if we can still grow then grow it with the growthSpeed
   boolean segmentGrown = false;
   if (segmentLength < plant.maxSegmentLenght){
     segmentGrown = true;
     //segmentLength += plant.growthSpeed*plant.secondFromPreviousUpdate;
     segmentLength += plant.growthSpeed;
     if (segmentLength > plant.maxSegmentLenght) segmentLength = plant.maxSegmentLenght;
   }  
   //if the startpos changed or the plant was grown then endpos needs to be changed as well
   if (startposChanged || segmentGrown) {     
       endpos.set(direction);
       endpos.mult(segmentLength);
       endpos.add(startpos);
   } 
   //if we do not have yet, then make next segment if we are long enough
   if (segmentLength > plant.segmentChildbirtLengt && nextSegment == null && !branchEnding){
       if (random(0,1) > segmentcount/plant.maxBranchLength){
                nextSegment = new PlantSegment(this, plant);  
               //println("new segment");
       }
       else{
         branchEnding = true;
       }
         

   } 
   //if we are long enough to branch and have not tried to do that yet, do it
   if (segmentLength > plant.segmentBranchLenght && branchTried == false){
     branchTried = true;
     float r = random(0, 1);
     if (r < branchProbability){
       //createBranch successfull
       PVector d = direction.copy();
       
       d.add(random(-plant.branchWildness, plant.branchWildness), random(-plant.branchWildness, plant.branchWildness), random(-plant.branchWildness, plant.branchWildness));
       branchSegment = new PlantSegment(this, plant, d.normalize());
       
     }  
   }  
   
   
   // then update all the leaf of this branch and the next segments if they are not null
   if (leaf != null) leaf.updateLeaf();
   if (nextSegment != null) nextSegment.update();  
   if (branchSegment != null) branchSegment.update();  
 }
 void drawSegment(){
   //do the drawing of this segment here
   pushMatrix();
   
  
   drawCylinder(direction, startpos, endpos, startThickness, endThickness,10);
   
   
   popMatrix();
   //then draw the next segments
   //println("drawing with startpos " + startpos);
   if (leaf != null) leaf.drawLeaf();
   if (nextSegment != null) {
     nextSegment.drawSegment();
     //println("drawing next with startpos " +nextSegment.startpos);
   }  
   if (branchSegment != null) branchSegment.drawSegment();  
   
 }  
 
 
 
 

  
 
 
 
 
 

}
