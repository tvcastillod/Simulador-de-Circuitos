class Boton {
  int rectSize = 60;
  color rectColor = color(0);
  int rectX, rectY;
  boolean rectOver = false;

  public Boton(color rC, int x, int y) {
    rectColor = rC;
    rectX = x;
    rectY = y;
  }

  void draw() {
    if (rectOver) {
      fill(150);
    } else {
      fill(rectColor);
    }
    stroke(255);
    rect(rectX, rectY, rectSize, rectSize);
  }

  void overRect(int x, int y) {
    if ( overRect(rectX, rectY, rectSize, rectSize) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}