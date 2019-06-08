

/** Handles camera movement */
class ActionCam {
  
  Tweaker tweaker;
  
  PVector focus = new PVector();
  PVector position = new PVector();
  PVector up = new PVector(0, 1, 0);
  
  float fieldOfView = 60;
  
  float rotateCameraDistance = 100f;

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

<<<<<<< HEAD
=======
    float dist = 4f;
>>>>>>> 08252e20d22ae8ecfa19adccd6a8f4d0f7596a06

    position.set(rotateCameraDistance * cos(rotationAngle)  * sin(elevationAngle),
                 rotateCameraDistance * cos(elevationAngle) - rotateCameraDistance / 2f,
                 rotateCameraDistance * -sin(rotationAngle)  * sin(elevationAngle) );


    updateCamera();
  }
  
  void changeDistance(float amount) {
    rotateCameraDistance += amount;
  }
    
  private void updateCamera() {

    perspective();
    perspective(fieldOfView / 360 * TAU, (float)width / height, 0.1f, 10000f);
    camera(position.x, position.y, position.z,
           focus.x, focus.y, focus.z, 
           up.x, up.y, up.z);
           
           
  }
    
}
