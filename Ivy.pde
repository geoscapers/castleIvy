class Ivy{
  PlantSegment root; 
  int segmentAmount; 
  //1 = 1m
  float maxSegmentLenght = 0.1;
  float segmentBranchLenght = 0.8*maxSegmentLenght;
  float growthSpeed = 0.01;  
  //amount of sides in the sylinder of the ivy branches 
  int segmentSideAmount = 10;
  PVector upDirection;
  
  
  Ivy(PVector startpos, PVector upDirection){
    this.upDirection.set(upDirection);
    root = new PlantSegment(startpos, this);
  } 
  
  private void updateIvy(){
    //if anything of the ivy needs to be updated do it here
    
    //then update the root (and all the following branches)
    root.update();
  }
  
  void drawIvy(){
    updateIvy();
    
    //draw one segment at a time
    root.drawSegment();
  }  
  
}  
  
