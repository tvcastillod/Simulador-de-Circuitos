ArrayList<CircElm> elem;
Boton[] bt;

void initializeElem() {
  bt = new Boton[2];
  elem = new ArrayList<CircElm>();
}

void addElem( int i ) {
  CircElm newElem = null;
  if ( i == 0 ) newElem = new FuenteVolt(mouseX, mouseY, radians(0), mouseX-40, mouseY, mouseX+40, mouseY);
  if ( i == 1 ) newElem = new Resist(mouseX, mouseY, radians(90), mouseX-45, mouseY, mouseX+45, mouseY);
  elem.add( newElem );
}

void setup() {
  size(800, 800);
  initializeElem();
  bt[0] = new Boton(color(0), 100, 100);
  bt[1] = new Boton(color(1), 100, 300);
}

void draw() {
  background(255);
  for ( int i = 0; i < 2; i++ ) {
    bt[i].draw();
    bt[i].overRect(mouseX, mouseY);
  }
  for ( CircElm e : elem ) {
    e.draw();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    for ( int i = 0; i < 2; i++ ) {
      if (bt[i].rectOver) {
        addElem(i);
      }
    }
    for (int i = 0; i<elem.size(); i++) {
      if (dist (mouseX, mouseY, elem.get(i).trans.x, elem.get(i).trans.y) <= 25) {
        elem.get(i).rot += radians(90);
      }
    }
  }
  if (mouseButton == LEFT) {
    for (int i=0; i<elem.size(); i++) {
      if (dist (mouseX, mouseY, elem.get(i).trans.x, elem.get(i).trans.y) <= 25) {
        elem.get(i).mov = true;
      }
      if (dist (mouseX, mouseY, elem.get(i).node1.x, elem.get(i).node1.y) <= 12) {
        elem.get(i).dragN1 = true;
      }
      if (dist (mouseX, mouseY, elem.get(i).node2.x, elem.get(i).node2.y) <= 12) {
        elem.get(i).dragN2 = true;
      }
    }
  }
}

void mouseReleased() {
  int idx = 0;
  for ( int i = 0; i < elem.size(); ++i ) {
    if ( elem.get(i).mov || elem.get(i).dragN1 || elem.get(i).dragN2) {
      idx = i;
    }
    elem.get(i).mov = false;
    elem.get(i).dragN1 = false;
    elem.get(i).dragN2 = false;
    println(idx);
  }
  for (int i=0; i<elem.size(); i++) {
    if ( i == idx ) continue;
    if (dist( elem.get(i).node1.x, elem.get(i).node1.y, elem.get(idx).node2.x, elem.get(idx).node2.y) <= 30) {
      elem.get(i).node1.x = elem.get(idx).node2.x;
      elem.get(i).node1.y = elem.get(idx).node2.y;
      //elem.get(i).addConnection(i);
    }
    if (dist( elem.get(i).node2.x, elem.get(i).node2.y, elem.get(idx).node1.x, elem.get(idx).node1.y) <= 30) {
      elem.get(i).node2.x = elem.get(idx).node1.x;
      elem.get(i).node2.y = elem.get(idx).node1.y;
      //elem.get(i).addConnection(i);
    }
  }
}
