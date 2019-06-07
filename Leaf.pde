class Leaf{
  PlantSegment parentSegment;
  Ivy plant;
  
  Leaf(Ivy plant, PlantSegment parentSegment){
    this.plant = plant;
    this.parentSegment = parentSegment;
  }
  
  
  void updateLeaf(){
      //do all of the updating of the leaf here
  }
  
  void drawLeaf(){
     //do the drawing of the leaf here
  }  

}  
