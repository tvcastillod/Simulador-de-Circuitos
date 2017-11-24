class Boton {
  int rectSize;
  color rectColor = color(0);
  float rectX, rectY;
  int width, height;
  boolean rectOver = false;
  PShape img;
  String word;

  public Boton(color rC, float x, float y, String source, int w, int h, String s, int rS) {
    rectColor = rC;
    width = w;
    height = h;
    rectX = x;
    rectY = y;
    word = s;
    rectSize = rS;
    img = loadShape(source);
  }

  void draw() {
    if (rectOver) {
      fill(#BCC0C6);
    } else {
      noFill();
    }
    pushStyle();
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text(word, rectX, rectY-40);
    popStyle();
    strokeWeight(3);
    rectMode(CENTER);
    rect(rectX, rectY, rectSize, rectSize);
    pushStyle();
    shapeMode(CENTER);
    shape(img, rectX, rectY, width, height);
    popStyle();
  }

  void overRect(float x, float y) {
    if ( overRect(rectX, rectY, rectSize, rectSize) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }

  boolean overRect(float x, float y, int width, int height) {
    if (mouseX+25 >= x && mouseX+25 <= x+width && mouseY+25 >= y && mouseY+25 <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}