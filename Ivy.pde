class Ivy{
  PlantSegment root; 
  int segmentAmount = 0; 
  //1 = 1m
  float maxSegmentLenght = 1;
  float segmentBranchLenght = 0.9*maxSegmentLenght;
  float segmentChildbirtLengt = 0.5*maxSegmentLenght;
  float growthSpeed = 0.05; 
  float branchProbability = 0.2;
  
  
  //amount of sides in the sylinder of the ivy branches 
  int segmentSideAmount = 10;
  PVector upDirection = new PVector();
  float previousSecondsFromStart;
  float secondFromPreviousUpdate;
  float branchAngle = 45;
  float branchWildness = 1.2;
  float turnstrength = 0.6;
  int branchamount = 1;
  int maxBranchLength = 100;
  
  
  
  Ivy(PVector startpos, PVector upDirection){
    this.upDirection.set(upDirection);
    root = new PlantSegment(startpos, this);
   previousSecondsFromStart = secondsFromStart();
   secondFromPreviousUpdate = secondsSince(previousSecondsFromStart);
  } 
  
  void addSegmentAmount(){
    segmentAmount++;
  }  
  

  
  private void updateIvy(){
    //if anything of the ivy needs to be updated do it here

    
    secondFromPreviousUpdate = secondsSince(previousSecondsFromStart);
    previousSecondsFromStart = secondsFromStart();
    
    //then update the root (and all the following branches)
    root.update();
  }
  
  void drawIvy(){
    updateIvy();
    
    //draw one segment at a time
    root.drawSegment();
  }  
  
}  
  
