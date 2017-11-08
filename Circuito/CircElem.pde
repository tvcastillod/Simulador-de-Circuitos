abstract class CircElm {
  protected PVector trans;
  protected float rot;
  protected int mov = -1;
  protected boolean dragged = false;
  protected PShape imgCap;
  protected PVector node1, node2;

  public CircElm(float x, float y) {
    trans = new PVector(x, y);
  }

  public CircElm(float x, float y, float r, float x1, float y1, float x2, float y2, String source) {
    trans = new PVector(x, y);
    node1 = new PVector(x1, y1);
    node2 = new PVector(x2, y2);
    rot = r;
    imgCap = loadShape(source);
  }

  public void draw() {
    pushStyle();
    pushMatrix();
    translate(trans.x, trans.y);
    rotate(rot);
    noFill();
    drawElem();
    stroke(255, 18, 18); 
    strokeWeight(10);
    point(node1.x, node1.y); //entrada
    println(node1.x, node1.y);
    stroke(0);
    strokeWeight(10);
    noFill();
    point(node2.x, node2.y); //salida
    popMatrix();
    popStyle();
    //for (int i=0; i<elem.size(); i++) {
    // if (i > 0) { 
    //  println(elem.get(i).trans.x-48, elem.get(i).trans.y, elem.get(i-1).trans.x-48, elem.get(i-1).trans.y);
    //  println(mouseX, mouseY);
    // }
    //}
    if (mov != -1) {
      if (mousePressed) {
        trans.x = mouseX;
        trans.y = mouseY;
      }
    }
    if (dragged) {
      if (mousePressed) {
        node1.x = mouseX;
        node1.y = mouseY;
      }
    }
  }

  protected abstract void drawElem();

  void translation(float x, float y) {
    trans.x = x;
    trans.y = y;
  }

  void setNode1(float x1, float y1) {
    node1.x = x1;
    node1.y = y1;
  }

  void setNode2(float x2, float y2) {
    node2.x = x2;
    node2.y = y2;
  }
}