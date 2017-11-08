class FuenteVolt extends CircElm {

  final static String IMG_SOURCE = "imgs/fuenteV.svg";

  public FuenteVolt(float x, float y, float r, float x1, float y1, float x2, float y2) {
    super(x, y, r, x1, y1, x2, y2, IMG_SOURCE);
  }

  @Override
    void drawElem() {
    noStroke();
    rectMode(CENTER);
    rect(0, 0, 50, 50);
    shape(imgCap, -25, -35, 50, 69);
    line(0, -35, node1.x, node1.y);
    line(0, 35, node2.x, node2.y);
  }
}