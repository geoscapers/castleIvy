
int STAR_COUNT = 1000;

float[] starX = new float[STAR_COUNT];
float[] starY = new float[STAR_COUNT];
float[] starZ =new float[STAR_COUNT];

void setupStars() {
  
 for (int i = 0; i < STAR_COUNT; i++) {
   float skySize = 1000;
   starX[i] = random(-skySize, skySize);
   starY[i] = random(-400, -100);
   starZ[i] = random(-skySize, skySize);
 }  
}

void drawSky() {
  drawStars();
}


void drawStars() {
 
  float starForce = tweaker.value("stars", 1f);
  
  float starSize = max(1f, starForce);
  
  if (starForce > 0.01) {
    stroke(55, 34, 95, starForce * 100f);
    strokeWeight(3.5 * starSize);
    beginShape(POINTS);
    for (int i = 0; i < STAR_COUNT; i++) {
      vertex(starX[i], starY[i], starZ[i]);
    }
    endShape();
  }
  
  
}
