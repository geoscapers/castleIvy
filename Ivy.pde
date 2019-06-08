class Ivy{
  PlantSegment root; 
  int segmentAmount = 0; 

  float maxSegmentLenght = 0.1;
  float segmentBranchLenght = 0.9*maxSegmentLenght;
  float segmentChildbirtLengt = 0.5*maxSegmentLenght;
  float growthSpeed = 0.005; 
  float branchProbability = 0.042;
  PVector tempForDissat = new PVector();
  
  
  //amount of sides in the sylinder of the ivy branches 
  int segmentSideAmount = 10;
  PVector upDirection = new PVector();
  float previousSecondsFromStart;
  float secondFromPreviousUpdate;
  float branchAngle = 45;
  float branchWildness = 1.2;
  float turnstrength = 0.5;
  int branchamount = 1;
  int maxBranchLength = 1200;
  float maxBranchWidth = 0.5;
  float branchGrowth = 0.01;
  float leafGrowthSpeed = branchGrowth*0.4;
  XoroShiro rnd = new XoroShiro();
  PVector mean = new PVector();
  PVector prevMean = new PVector() ;
  float ivyseed = 0;
  float leafprob = 0.4;
  float thicknesLoss = 0.99;
  float freshColorChangeRate = 0.2;
  float colorChangeRate = 0.05;
  float leafColorChangeRate = 0.08;
  
  
  color branchColor = color(33, 53, 50);
  color rootColor = color(5, 30, 30);
  color sproutColor = color(35, 72, 78);
  color leafColor = color(35, 60, 50);
  
  
  Ivy(PVector startpos, PVector upDirection){
    this.upDirection.set(upDirection);
    root = new PlantSegment(startpos, this);
   previousSecondsFromStart = secondsFromStart();
   secondFromPreviousUpdate = secondsSince(previousSecondsFromStart);
   PVector prevMean = startpos;
   ivyseed = random(0, 255);
   
  } 
  
  void addSegmentAmount(){
    segmentAmount++;
  }  
  
  void addBranchAmount(){
    branchamount++;
  }  
  
  void addToMean(PVector v){
    mean.add(v);
  }  
  

  
  private void updateIvy(){
    //println(segmentAmount);
    
    
    //null the mean
    mean.set(root.startpos);
    //if anything of the ivy needs to be updated do it here
    //println(branchamount);
    
    secondFromPreviousUpdate = secondsSince(previousSecondsFromStart);
    previousSecondsFromStart = secondsFromStart();
    
    root.startThickness += branchGrowth*secondFromPreviousUpdate;
    if (root.startThickness > maxBranchWidth) root.startThickness = maxBranchWidth;
    //then update the root (and all the following branches)
    root.update();
    prevMean.set(mean.div(branchamount));
    
  }
  
  void drawIvy(){
    noStroke();
    
    updateIvy();
    
    //draw one segment at a time
    root.drawSegment();
  }  
  
}  
  
