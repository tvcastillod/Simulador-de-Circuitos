abstract class CircElm {
  protected PVector trans;
  protected float rot;
  protected boolean mov, dragN1, dragN2 = false;
  protected boolean dragged = false;
  protected PShape imgCap;
  protected PVector node1, node2;
  protected ArrayList<CircElm> connect;

  public CircElm(float x, float y ) {
    trans = new PVector(x, y);
    connect = new ArrayList<CircElm>();
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
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    translate(node1.x, node1.y);
    noFill();
    drawNode1();
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    translate(node2.x, node2.y);
    noFill();
    drawNode2();
    popMatrix();
    popStyle();

    stroke(0);
    strokeWeight(2);
    line(trans.x-35, trans.y, node1.x, node1.y);
    line(trans.x+35, trans.y, node2.x, node2.y);


    if (mousePressed) {
      if (mov) {
        trans.x = mouseX;
        trans.y = mouseY;
        for (int i=0; i<elem.size(); i++) {
          if (elem.get(i).mov == true) {
            elem.get(i).node1.x = elem.get(i).trans.x-45;
            elem.get(i).node1.y = elem.get(i).trans.y;
            elem.get(i).node2.x = elem.get(i).trans.x+45;
            elem.get(i).node2.y = elem.get(i).trans.y;
          }
        }
      }
      if (dragN1) {
        node1.x = mouseX;
        node1.y = mouseY;
      }
      if (dragN2) {
        node2.x = mouseX;
        node2.y = mouseY;
      }
    }
  }

  //void addConnection( int i ) {
  //  CircElm newConnection;
  //  if(){
  //    connect.add( newConnection );
  //  }
  //}

  protected abstract void drawElem();
  protected abstract void drawNode1();
  protected abstract void drawNode2();

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
