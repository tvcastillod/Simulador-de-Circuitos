class Volt extends CircElm {

  final static String IMG_SOURCE = "imgs/voltimetro.svg";

  public Volt(float x, float y, float r, float x1, float y1, float x2, float y2, int i, float v, String t) {
    super(x, y, r, x1, y1, x2, y2, i, IMG_SOURCE, v, t);
  }

  @Override
    void drawElem() {
    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(0, 0, 50, 50);
    shape(imgCap, -35, -25, 68, 50);
    fill(0);
    textSize(15);
    textAlign(CENTER);  
    text("Vol"+id, 0, -30);
    text("= " +valuevol + "V", 0, 40);
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