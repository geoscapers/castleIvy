class Ivy{
  //the first piece
  PlantSegment root; 
  
  //segments currently in the ivy
  int segmentAmount = 0; 
  //maximum length of one segment
  float maxSegmentLenght = 0.1;
  //length at wich the segmens cehecks if it branches
  float segmentBranchLenght = 0.9*maxSegmentLenght;
  //langth at wich a segment checks if it grows a child
  float segmentChildbirtLengt = 0.5*maxSegmentLenght;
  //the speed that the segments grow
  float growthSpeed = 0.005; 
  //the porbability that a new branch is formed, this is the base probability, it will drop in every branch, 
  //and if it does not happen there is a lower chanse a shorter branch will form
  float branchProbability = 0.042;
  
  //Temporary PVector used for the plantCenter dissipator
  PVector tempForDissat = new PVector();
  
  
  //amount of sides in the sylinder of the ivy branches 
  int segmentSideAmount = 5;
  //the direction of up for the ivy
  PVector upDirection = new PVector();
  //the time it took from start to the previous update, used in counting time between updates
  float previousSecondsFromStart;
  //seconds from previous update
  float secondFromPreviousUpdate;
  //a fudge parameter affecting on how big an angle a branch has
  float branchWildness = 1.2;
  //a fudge parameter affecting how scuiggly the plant is
  float turnstrength = 0.5;
  //running count on amount of branches 
  int branchamount = 1;
  //maximum segment amount in a branch (depth from root)
  int maxBranchLength = 1200;
  //maximum width of the plant at the root
  float maxBranchWidth = 0.5;
  //growthspeed of the branch
  float branchGrowth = 0.01;
  //growthspead of the leaf
  float leafGrowthSpeed = branchGrowth*0.4;
  //a random number where you can set seed
  XoroShiro rnd = new XoroShiro();
  //pvector used to count the mean position of the branch tips
  PVector mean = new PVector();
  //pvector used to count the mean position of the branch tips
  PVector prevMean = new PVector() ;
  //seed to this ivy, initialised with random, used to get diffent plants
  float ivyseed = 0;
  //probability that there will be a leaf in a segment (if there is a branch there is no leaf, and if it is the end there is always a leaf)
  float leafprob = 0.4;
  //parameter to multipy the thickness with for every next segment, bigger will make it thicker fr longer
  float thicknesLoss = 0.99;
  //the rate on wich fresh color changes 
  float freshColorChangeRate = 0.2;
  //the rate on wich the branch get broun
  float colorChangeRate = 0.05;
  //the rate on wich the leafs turn dark
  float leafColorChangeRate = 0.08;
  
  //color of you g sprouts and young leafs
  color sproutColor = color(35, 72, 78);
  //middlecolor of the branch, 
  color branchColor = color(33, 53, 50);
  //color of the root of the branch, and old branches
  color rootColor = color(5, 30, 30);
  //basecolor of the leafs, the leaf is randomisating this a bit
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
  
