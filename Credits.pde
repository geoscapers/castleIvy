

String credits = 
  "Forest Ivy Castle\n" +
  "\n" +
  "by GeoScapers\n" +
  "\n" +
  "coded in 29 hours\n" +
  "for Graffathon 2019\n" +
  "\n" +
  "  Ivy by Shiera\n" +
  "  Castle by fractalpixel\n" +
  "  Background by SierraFox\n" +
  "\n" +
  "Music: \"Majestic Hills\"\n" + 
  "    by: Kevin MacLeod\n" +
  "    (creative commons cc-by)\n";

PFont creditFont;

String FONT_NAME = "JosefinSans-Bold.ttf";

// Setup font etc.  Call from setup.
void initCredits() {
  creditFont = createFont(FONT_NAME, 32);
  
  int fontSize = 32 * width / 800; // Resolution independent 
  textSize(fontSize);
}

void drawCredits() {
  
  float relPos = tweaker.value("creditsPos", -1);
  fill(0, 0, 100, 75);
  if (relPos > -0.99f) {
    lights();
    float creditPos = -relPos * height;
    fill(0, 0, 100, 75);
    text(credits, width * 0.2f, creditPos);
  }  
}
