ArrayList<CircElm> elem;
Boton[] bt;

void initializeElem() {
  bt = new Boton[2];
  elem = new ArrayList<CircElm>();
}

void addElem( int i ) {
  CircElm newElem = null;
  if ( i == 0 ) newElem = new FuenteVolt(mouseX, mouseY, radians(45), 0, -35, 0, 35);
  if ( i == 1 ) newElem = new Resist(mouseX, mouseY, radians(-45), -48, 0, 48, 0);
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
        elem.get(i).rot += radians(45);
      }
    }
  }
  if (mouseButton == LEFT) {
    for (int i=0; i<elem.size(); i++) {
      if (dist (mouseX, mouseY, elem.get(i).trans.x, elem.get(i).trans.y) <= 25) {
        elem.get(i).mov = i;
      }
      if (dist (mouseX, mouseY, elem.get(i).node1.x, elem.get(i).node1.y) <= 20) {
        elem.get(i).dragged = true;
      }
      //if (dist (mouseX, mouseY, elem.get(i).node2.x, elem.get(i).node2.y) <= 10) {
      //  elem.get(i).dragged = true;
      //}
    }
  }
}

void mouseReleased() {
  int idx = 0;
  for ( int i = 0; i < elem.size(); ++i ) {
    if ( elem.get(i).mov >= 0 ) {
      idx = i;
    }
    elem.get(i).mov = -1;
    elem.get(i).dragged = false;
  }
  for (int i=0; i<elem.size(); i++) {
    if ( i == idx ) continue;
    if (dist( elem.get(i).trans.x, elem.get(i).trans.y, elem.get(idx).trans.x, elem.get(idx).trans.y)<=200) {
      elem.get(i).trans.x = elem.get(idx).trans.x+90;
      elem.get(i).trans.y = elem.get(idx).trans.y;
    }
  }
}