class Boton {
  int rectSize = 60;
  color rectColor = color(0);
  int rectX, rectY, width, height, posx, posy;
  boolean rectOver = false;
  PShape img;

  public Boton(color rC, int x, int y, String source, int px, int py, int w, int h) {
    rectColor = rC;
    width = w;
    height = h;
    posx = px;
    posy = py;
    rectX = x;
    rectY = y;
    img = loadShape(source);
  }

  void draw() {
    if (rectOver) {
      fill(#BCC0C6);
    } else {
      noFill();
    }
    rect(rectX, rectY, rectSize, rectSize);
    shape(img, posx, posy, width, height);
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