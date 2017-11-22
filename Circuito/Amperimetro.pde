class Amp extends CircElm {

  final static String IMG_SOURCE = "imgs/amperimetro.svg";

  public Amp(float x, float y, float r, float x1, float y1, float x2, float y2, int  i) {
    super(x, y, r, x1, y1, x2, y2, i, IMG_SOURCE);
  }

  @Override
    void drawElem() {
    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(0, 0, 50, 50);
    shape(imgCap, -32, -22, 66, 44);  
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