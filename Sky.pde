
float[] starX = new float[1000];
float[] starY = new float[1000];
float[] starZ =new float[1000];

void setupStars() {
  
 for (int i = 0; i < 1000; i++) {
   starX[i] = random(-width * 0.16 -100, width * 0.16 -100);
   starY[i] = random(-150, -60);
   starZ[i] = random(-width * 0.16, width * 0.16);
 }
  
}

void drawSky() {
  background(50, 20, 70);
  drawStars();
}


void drawStars() {
 
  stroke(55, 34, 95);
  strokeWeight(0.5);
  beginShape(POINTS);
  for (int i = 0; i < 1000; i++) {
    vertex(starX[i], starY[i], starZ[i]);
  }
  endShape();
  
  
}
