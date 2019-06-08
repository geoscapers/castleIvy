

/** Handles camera movement */
class ActionCam {
  
  Tweaker tweaker;
  
  PVector focus = new PVector();
  PVector position = new PVector();
  PVector up = new PVector(0, 1, 0);

  ActionCam(Tweaker tweaker) {
    this.tweaker = tweaker;
  }

  void update() {
    mouseRotateLook();
    
  }
  
  void mouseRotateLook() {

    focus.set(0, 0, 0);
    
    float rotationAngle = map(mouseX, 0, width, 0, TAU);
    float elevationAngle = map(mouseY, 0, height, 0, TAU/2);

    float dist = 4f;

    position.set(dist * cos(rotationAngle)  * sin(elevationAngle),
                 dist * cos(elevationAngle),
                 dist * -sin(rotationAngle)  * sin(elevationAngle) );
  
    updateCamera();
  }
  
    
  private void updateCamera() {
    camera(position.x, position.y, position.z,
           focus.x, focus.y, focus.z, 
           up.x, up.y, up.z);    
  }
    
}
