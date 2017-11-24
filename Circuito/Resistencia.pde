class Resist extends CircElm {

  final static String IMG_SOURCE = "imgs/resistencia.svg";

  public Resist(float x, float y, float r, float x1, float y1, float x2, float y2, int i, float v) {
    super(x, y, r, x1, y1, x2, y2, i, IMG_SOURCE, v);
  }

  @Override
    void drawElem() {
    value = val.getValue("R"+id);
    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(0, 0, 50, 50);
    shape(imgCap, -50, -27, 100, 55); 
    fill(0);
    textSize(15);
    textAlign(CENTER);
    text("R"+id, 0, -20);
    text("= "+value, 0, 30);
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