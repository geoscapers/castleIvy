

/** Handles camera movement */
class ActionCam {
  
  Tweaker tweaker;
  
  PVector focus = new PVector();
  PVector position = new PVector();
  PVector up = new PVector(0, 1, 0);
  
  float fieldOfView = 60;
  
  float rotateCameraDistance = 100f;

  private int prevCameraMode = -1;

  private PVector prevCameraPos = new PVector(); 
  private PVector cameraVel = new PVector(); 

  private PVector hoverPos = new PVector(-20, -40, 30); 
  private PVector towerPos = new PVector(1, -40, 3); 
  private PVector distantPos = new PVector(200, -140, 100); 

  ActionCam(Tweaker tweaker) {
    this.tweaker = tweaker;
  }

  void update() {    
    float cameraDistance = tweaker.value("cameraDistance", 10);
    float rotationAngle = tweaker.value("cameraRotation", 0);
    float pitchAngle = tweaker.value("cameraPitch", 0);
    float chaseAcceleration = tweaker.value("cameraChaseAcceleration", 0.01);
    float sideX = tweaker.value("cameraSideX", 0);
    
    int cameraMode = (int)tweaker.value("cameraMode", 0);
    if (cameraMode <= 0) {
      // Dev camera
      mouseRotateLook();
    }
    else if (cameraMode == 1) {
      // Circle castle camera
      focus.set(0, 0, 0);
      rotoCamera(cameraDistance, rotationAngle, pitchAngle);
    }
    else if (cameraMode == 2) {
      // Circle other point
      focus.set(sideX, -1, 0);
      rotoCamera(cameraDistance, rotationAngle, pitchAngle);
    }
    else if (cameraMode == 3) {
      activateChaseCam(ivy1.branchPos, ivy1.branchPos, cameraMode, cameraDistance, chaseAcceleration);
    }
    else if (cameraMode == 4) {
      activateChaseCam(ivy3.branchPos, ivy4.branchPos, cameraMode, cameraDistance, chaseAcceleration);
    }
    else if (cameraMode == 5) {
      activateChaseCam(ivy5.branchPos, ivy5.branchPos, cameraMode, cameraDistance, chaseAcceleration);
    }
    else if (cameraMode == 6) {
      if (prevCameraMode != cameraMode) {
        position.set(distantPos);
        cameraVel.set(-10,-10, 2);
      }
      
      focus.set(towerPos);
      chaseCamera(hoverPos, chaseAcceleration);
    }
    else if (cameraMode == 7) {
      activateChaseCam(ivy5.branchPos, ivy2.branchPos, cameraMode, cameraDistance, chaseAcceleration);
    }
   
    prevCameraMode = cameraMode;
    prevCameraPos.set(position);
  }

  void activateChaseCam(PVector target, PVector foc, int mode, float dist, float acc) {
    if (prevCameraMode != mode) {
      position.set(target).add(-0.4, -dist*0.8, -1);
      cameraVel.set(0,0,0);
    }
    
    // Chase ivy x
    focus.set(foc);
    chaseCamera(target, acc);
  }
  
  private PVector tempAcc = new PVector();
  void chaseCamera(PVector target, float chaseAcceleration) {
    
    /*
    // Accelerate towards target
    float dt = (float)tweaker.getTime().getCurrentStepElapsedSeconds();
    tempAcc.set(target).sub(position).normalize().mult(chaseAcceleration * dt);
    
    // Update velocity
    addScaled(cameraVel, tempAcc, dt);

    // Update pos
    addScaled(position, cameraVel, dt);
    */
    
    // Simpler, non exploding
    position.lerp(target, chaseAcceleration);

    updateCamera();
  }
  
  void rotoCamera(float dist, float rotationAngle, float pitchAngle) {
    position.set(dist * cos(TAU*rotationAngle/360)  * sin(TAU*pitchAngle/360),
                 dist * cos(TAU*pitchAngle/360) - dist / 2f,
                 dist * -sin(TAU*rotationAngle/360)  * sin(TAU*pitchAngle/360) );

    updateCamera();
  }
  
  
  void mouseRotateLook() {
    focus.set(0, 0, 0);
    
    float rotationAngle = map(mouseX, 0, width, 0, TAU);
    float elevationAngle = map(mouseY, 0, height, 0, TAU/2);

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
