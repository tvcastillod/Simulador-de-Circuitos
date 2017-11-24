class FuenteVolt extends CircElm {

  final static String IMG_SOURCE = "imgs/fuenteV.svg";

  public FuenteVolt(float x, float y, float r, float x1, float y1, float x2, float y2, int i, float v) {
    super(x, y, r, x1, y1, x2, y2, i, IMG_SOURCE, v);
  }

  @Override
    void drawElem() {
    value = val.getValue("V"+id);
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(0, 0, 50, 50);
    shape(imgCap, -26, -40, 52, 80);
    fill(0);
    textSize(15);
    textAlign(CENTER);
    text("V"+id, -40, 0);
    text("= "+value, 40, 0);
  }
  void drawNode1() {
    stroke(255, 18, 18); 
    strokeWeight(12);
    point(0, 0); //entrada
  }
  void drawNode2() {
    stroke(0);
    strokeWeight(12);
    point(0, 0); //salida
  }
}