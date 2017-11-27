abstract class CircElm {
  
  protected PVector trans;
  protected float rot = 0.0;
  protected boolean mov, dragN1, dragN2 = false;
  protected PShape imgCap;
  protected Nodo node1, node2;
  public int id;
  public String type;
  protected ArrayList<Nodo> nod1;
  protected ArrayList<Nodo> nod2;
  protected float value;

  public CircElm(float x, float y, float r, float x1, float y1, float x2, float y2, int i, String source, float v, String t) {
    trans = new PVector(x, y);
    node1 = new Nodo(0, new PVector(x1, y1));
    node2 = new Nodo(0, new PVector(x2, y2));
    nod1 = new ArrayList<Nodo>();
    nod2 = new ArrayList<Nodo>();
    id = i;
    rot = r;
    type = t; 
    imgCap = loadShape(source);
    value = v;
  }

  public void draw() {
    stroke(0);
    strokeWeight(3);
    line(node2.posicion.x, node2.posicion.y, node1.posicion.x, node1.posicion.y);
    pushStyle();
    stroke(c);
    strokeWeight(2);
    dash.line(node2.posicion.x, node2.posicion.y, node1.posicion.x, node1.posicion.y);
    popStyle(); 
    
    pushStyle();
    pushMatrix();
    translate(trans.x, trans.y);
    rotate(rot);
    rotate(atan2(node1.posicion.y-trans.y, node1.posicion.x-trans.x));
    noFill();
    drawElem();
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    translate(node1.posicion.x, node1.posicion.y);
    noFill();
    drawNode1();
    popMatrix();
    popStyle();

    pushStyle();
    pushMatrix();
    translate(node2.posicion.x, node2.posicion.y);
    noFill();
    drawNode2();
    popMatrix();
    popStyle();

    if (mousePressed) {
      if (mov) {
        trans.x = mouseX;
        trans.y = mouseY;
        for (int i=0; i<elem.size(); i++) {
          if (elem.get(i).mov == true) {
            elem.get(i).node1.posicion.x = elem.get(i).trans.x-45;
            elem.get(i).node1.posicion.y = elem.get(i).trans.y;
            elem.get(i).node2.posicion.x = elem.get(i).trans.x+45;
            elem.get(i).node2.posicion.y = elem.get(i).trans.y;
          }
        }
      }
      if (dragN1) {
        node1.posicion.x = mouseX;
        node1.posicion.y = mouseY;
      }
      if (dragN2) {
        node2.posicion.x = mouseX;
        node2.posicion.y = mouseY;
      }
      if (dragN1 == true || dragN2 == true ) {
        trans.x = (node1.posicion.x+node2.posicion.x)/2;
        trans.y = (node1.posicion.y+node2.posicion.y)/2;
      }
    }
  }

  protected abstract void drawElem();
  protected abstract void drawNode1();
  protected abstract void drawNode2();

  void translation(float x, float y) {
    trans.x = x;
    trans.y = y;
  }

  void setNode1(float x1, float y1, float v1){
    node1.posicion.x = x1;
    node1.posicion.y = y1;
  }
  
  void setVoltage(float v1){
    node1.voltage = v1;
  }

  void setNode2(float x2, float y2){
    node2.posicion.x = x2;
    node2.posicion.y = y2;
  }
}