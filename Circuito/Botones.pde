class Boton {
  int rectSize = 60;
  color rectColor = color(0);
  int rectX, rectY, width, height;
  boolean rectOver = false;
  PShape img;
  String word;

  public Boton(color rC, int x, int y, String source, int w, int h, String s) {
    rectColor = rC;
    width = w;
    height = h;
    rectX = x;
    rectY = y;
    word = s;
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

  void overRect(int x, int y) {
    if ( overRect(rectX, rectY, rectSize, rectSize) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX+25 >= x && mouseX+25 <= x+width && mouseY+25 >= y && mouseY+25 <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}