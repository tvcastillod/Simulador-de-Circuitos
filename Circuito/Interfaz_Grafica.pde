class IG {
  PFont font;

  void draw() {
    fill(#2D3655);
    font = createFont("Book Antiqua Bold", 50);
    textFont(font);
    pushStyle();
    textAlign(CENTER, BOTTOM);
    text("Simulador de Circuitos", width/2, 100);
    stroke(0);
    fill(255);
    rectMode(CENTER);
    rect(width/2-10, height/2-30, 800, 580);
    noFill();
    rect(150, height/2-30, 200, 580);
    rect(150, height/2+350, 200, 150);
    popStyle();
  }
}