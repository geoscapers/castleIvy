class Ivy{
  PlantSegment root; 
  int segmentAmount; 
  float maxSegmentLenght = 1;
  float growthSpeed = 0.5;
  
  
  Ivy(float posx, float posy, float posz){
    root = new PlantSegment(posx, posy, posz, this);
  } 
  
  void updateIvy(){
    //if anything of the ivy needs to be updated do it here
    
    //then update the root (and all the following branches)
    root.update();
  }
  
  void drawIvy(){
    
    //draw one segment at a time
    root.drawSegment();
  }  
  
}  
  
