class Resist extends CircElm {

  final static String IMG_SOURCE = "imgs/resistencia.svg";

  public Resist(float x, float y, float r, float x1, float y1, float x2, float y2) {
    super(x, y, r, x1, y1, x2, y2, IMG_SOURCE);
  }

  @Override
    void drawElem() {
    noStroke();
    rectMode(CENTER);
    rect(0, 0, 50, 50);
    shape(imgCap, -58, -27, 117, 55);
    stroke(0);
    line(-48, 0, node1.x, node1.y);
    line(48, 0, node2.x, node2.y);
  }
}