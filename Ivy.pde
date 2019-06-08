class Ivy{
  PlantSegment root; 
  int segmentAmount = 0; 
  //1 = 1m
  float maxSegmentLenght = 0.1;
  float segmentBranchLenght = 0.9*maxSegmentLenght;
  float segmentChildbirtLengt = 0.5*maxSegmentLenght;
  float growthSpeed = 0.005; 
  float branchProbability = 0.05;
  
  
  //amount of sides in the sylinder of the ivy branches 
  int segmentSideAmount = 10;
  PVector upDirection = new PVector();
  float previousSecondsFromStart;
  float secondFromPreviousUpdate;
  float branchAngle = 45;
  float branchWildness = 1.2;
  float turnstrength = 0.5;
  int branchamount = 1;
  int maxBranchLength = 1000;
  float maxBranchWidth = 0.15;
  float branchGrowth = 0.01;
  
  
  
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
    
    root.startThickness += branchGrowth*secondFromPreviousUpdate;
    
    //then update the root (and all the following branches)
    root.update();
  }
  
  void drawIvy(){
    noStroke();
    updateIvy();
    
    //draw one segment at a time
    root.drawSegment();
  }  
  
}  
  
