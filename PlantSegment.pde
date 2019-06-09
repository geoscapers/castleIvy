class PlantSegment{
  //previous branchSegment, null if this is the root
  PlantSegment parent;
  //next plantSegment, null if not yet prodused, or this end
  PlantSegment nextSegment;
  //if it branches this is the branchSegment
  PlantSegment branchSegment;
  //the leaf from the end of this segment, might be null
  Leaf leaf;
  //the plant this segmentis a part on
  Ivy plant;
  //starting position of this segment
  PVector startpos = new PVector();
  //end position of this segment
  PVector endpos = new PVector();
  //thicknes of the start of this segment (radius?)
  float startThickness;
  //thicknes of the end of this segment (radius?)
  float endThickness;
  //direction of this segment, not changed after start
  PVector direction = new PVector();
  //current length of this segment
  float segmentLength; 
  //count from the root piece here
  int segmentcount;
  //boolean on if we have tried to branch, this is done only once
  boolean branchTried = false;
  //seed for the noice of this branch
  float noiseseed = 0;
  //probability that this branch will divide,gets lover on branches that have branched a lot
  float branchProbability = 0;
  //boolean on if this branch has ended (no next will be done if true)
  boolean branchEnding = false;
  //max amount of segments in this branch (from bottom) gets smaller when branched multiple times
  int maxBranchLength = 0;
  //boolean on if we have checked if this grows a leaf yet
  boolean triedLeaf = false;
  //when this segment was born, used to get its age, for example for the colors
  float segmentBirthSecondFromStart;
  //boolean on if the segment is fully grown, then those below it should e fully grown, and wont move anymore
  
  
 
 /*
 Construction for the root segment, when there is no parentSegment
 */
 PlantSegment(PVector startpos, Ivy plant){
   //just initialising stuff
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
   maxBranchLength = plant.maxBranchLength;
   segmentBirthSecondFromStart = secondsFromStart();
   
   
 }
 
 /*
 Construction for a segment that is not a root (has a parent segment), and not a new branch
 */
 PlantSegment(PlantSegment parent, Ivy plant){
   //initialise stuff
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
   segmentBirthSecondFromStart = secondsFromStart();
   this.segmentLength = 0;
   plant.addSegmentAmount();
   maxBranchLength = parent.maxBranchLength;
   //calculate new direction based on the old one and noice
   this.direction.add(
       map(noise(noiseseed+noisepos+113.13), 0, 1, -plant.turnstrength, plant.turnstrength), 
       map(noise(noiseseed+noisepos+231.12), 0, 1, -plant.turnstrength, plant.turnstrength), 
       map(noise(noiseseed+noisepos+21.21), 0, 1, -plant.turnstrength, plant.turnstrength));
       
    //sun attractor, in the direction of ivys up   
   direction.add(plant.upDirection.x*0.07, plant.upDirection.y*0.07, plant.upDirection.z*0.07);   
   //away from middle
   plant.tempForDissat.set(plant.prevMean).sub(startpos).normalize().mult(-0.05);
   direction.add(plant.tempForDissat);
   
   direction.normalize();
   
   
   
 }  
 
  /*
 Construction for a segment that is not a root (has a parent segment)  
 and are not given its direction
 */
 PlantSegment(PlantSegment parent, Ivy plant, PVector direction, float maxLengthMul){
   //initialise stuff
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
   //will branch less 
   branchProbability = plant.branchProbabilityMultiplier*parent.branchProbability;
   maxBranchLength = (int)(parent.maxBranchLength*maxLengthMul);
   segmentBirthSecondFromStart = secondsFromStart();
   
 } 
 
 void update(){
   
   //add here code for updating this segment
   //thickness
   if (parent != null){
     startThickness = parent.endThickness;
     
     endThickness = startThickness*plant.thicknesLoss;
     //if no branch end in a tip
     if (nextSegment == null && branchSegment == null){
       endThickness = 0;
     } 
     //othervise put a minimum width
     else{
       if (endThickness < 0.01)endThickness = 0.01;
     }  
   }
   else{
     endThickness = startThickness*plant.thicknesLoss;
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
       if (random(0,1) > segmentcount/maxBranchLength){
                nextSegment = new PlantSegment(this, plant);  
               //println("new segment");
       }
       else{
         branchEnding = true;
       }
         
   } 
   //if we are long enough to branch and have not tried to do that yet, do it
   if ( branchTried == false && segmentLength > plant.segmentBranchLenght){
     branchTried = true;
     if (plant.branchamount < plant.maxBranchAmount ){
     
       float r = random(0, 1);
       if (r < branchProbability){
         //createBranch successfull
         PVector d = direction.copy();
         
         d.add(random(-plant.branchWildness, plant.branchWildness), random(-plant.branchWildness, plant.branchWildness), random(-plant.branchWildness, plant.branchWildness));
         branchSegment = new PlantSegment(this, plant, d.normalize(), 0.85);
         plant.addBranchAmount();
         
       }  
       //if not try to make a shorter
       r = random(0, 1);
       if (r < branchProbability*0.1){
         //createBranch successfull
         PVector d = direction.copy();
         
         d.add(random(-plant.branchWildness, plant.branchWildness), random(-plant.branchWildness, plant.branchWildness), random(-plant.branchWildness, plant.branchWildness));
         branchSegment = new PlantSegment(this, plant, d.normalize(), 0.1);
         plant.addBranchAmount();
         
       }  
     }
   }  
   //if this is not gonna branch check if this shouls have a leaf
   if (leaf == null && branchSegment == null && branchTried == true && triedLeaf == false){
     float r = random(0, 1);
     triedLeaf = true;
     if (r < plant.leafprob){
       leaf = new Leaf(plant, this);
     }  
   } 
   //or if this is ending then then add always a leaf
   if (branchEnding && leaf == null) leaf = new Leaf(plant, this);
   //add ends to mean
   if (branchSegment == null && nextSegment == null){
       plant.addToMean(endpos);
   }  
   
   
   // then update all the leaf of this branch and the next segments if they are not null
   if (leaf != null) leaf.updateLeaf();
   if (nextSegment != null) nextSegment.update();  
   if (branchSegment != null) branchSegment.update();  
 }
 
 
 void drawSegment(){
   float since = secondsSince(segmentBirthSecondFromStart);
   float colorage = since*plant.freshColorChangeRate;
   if (colorage < 1){
     fill(lerpColor(plant.sproutColor, plant.branchColor, colorage));
   }  
   else{
     since -= 1/plant.freshColorChangeRate;
     colorage = since*plant.colorChangeRate;
     if (colorage > 1) colorage = 1;
     fill(lerpColor(plant.branchColor, plant.rootColor, colorage));
   }  
   
   //do the drawing of this segment here
   pushMatrix();
   
  
   drawCylinder(direction, startpos, endpos, startThickness, endThickness,plant.segmentSideAmount);
   
   
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
