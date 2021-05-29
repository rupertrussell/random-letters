/**
    Scattered Letters
    by Algirdas Rascius.
    http://www.openprocessing.org/sketch/1811
 
 */
  
PFont font;
float currentSize;
int count;
float padding = 1.4;
 
void setup() {
  size(2875, 3900);
  colorMode(HSB, TWO_PI, 1, 1, 1);
  initFont();
  smooth();
   
  initialize();
}
 
void initFont() {
  char[] chars = new char['Z'-'A'+1];
  for (char c='A'; c<='Z'; c++) {
    chars[c-'A'] = c;
  }
  font = createFont("Jokerman", 200, true, chars);
}
 
void draw() {
  if (currentSize > 10) {
    if (!randomLetter(currentSize)) {
      currentSize = currentSize*0.95;
    }
  }
}
 
void initialize() {
  background(color(0, 0, 1));
  currentSize = 1900;
  count = 0;
  
}
 
void keyPressed() {
  // initialize();
}
 
 
boolean randomLetter(float letterSize) {
  int intSize = (int)letterSize;
 
  PGraphics g = createGraphics(intSize, intSize, JAVA2D);
  g.beginDraw();
  g.background(color(0, 0, 1, 0));
  g.fill(color(0, 0, 0));
  g.textAlign(CENTER, CENTER);
  g.translate(letterSize/2, letterSize/2);
  g.rotate(random(TWO_PI));
  g.scale(letterSize/300);
  g.textFont(font);
  g.text((char)random('A', 'Z'+1), 0, 0);
  g.endDraw();
 
  PGraphics gMask = createGraphics(intSize , intSize  , JAVA2D);
  gMask.beginDraw();
  gMask.background(color(0, 0, 1, 1));
  gMask.image(g, 0, 0);
  gMask.filter(ERODE); 
  gMask.filter(ERODE);
  gMask.endDraw();
   
  for (int tries=50; tries>0; tries--) {
    int x = (int)random(width-intSize);
    int y = (int)random(height-intSize);
     
    boolean fits = true;
    for (int dx = 0; dx<intSize * padding && fits; dx++) {
      for (int dy = 0; dy<intSize * padding && fits; dy++) {
        if (brightness(gMask.get(dx, dy))<0.5) {
          if (brightness(get(x+dx, y+dy))<0.5) {
            fits = false;
          }
        }
      }
    }
    if (fits) {
      image(g, x, y);
      return true;
    }
  }
  return false;
}


void mousePressed ()
{
  
  String filename;
  count = count + 1;
  filename = "large-"+count+".png";
  saveFrame (filename);

}
