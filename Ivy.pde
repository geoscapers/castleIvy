class Ivy{
  PlantSegment root; 
  int segmentAmount; 
  float maxSegmentLenght = 1;
  float growthSpeed = 0.5;
  
  
  Ivy(float posx, float posy, float posz){
    root = new PlantSegment(posx, posy, posz, this);
  } 
  
  
  
}  
  
