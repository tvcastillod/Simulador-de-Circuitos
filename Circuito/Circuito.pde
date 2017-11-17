import garciadelcastillo.dashedlines.*;
import java.util.*;
DashedLines dash;
float dist = 0;
int cont = 0;
int idx;
int temp;
int c;
boolean run = false;
ArrayList<CircElm> elem;
Boton[] bt;

void initializeElem() {
  bt = new Boton[5];
  elem = new ArrayList<CircElm>();
}

void addElem( int i ) {
  CircElm newElem = null;
  if ( i == 0 ) newElem = new FuenteVolt(mouseX, mouseY, radians(270), mouseX, mouseY+45, mouseX, mouseY-45, cont); 
  if ( i == 1 ) newElem = new Resist(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont); 
  if ( i == 2 ) newElem = new Cable(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont);  
  elem.add( newElem );
  cont++;
}

boolean isConnected (CircElm elem1, CircElm elem2) {
  return elem1.nod1.contains( elem2.node1 ) || elem1.nod1.contains( elem2.node2 ) || elem2.nod1.contains( elem1.node1 ) || elem2.nod1.contains( elem1.node1 );
}

boolean paralelo(CircElm elem1, CircElm elem2) {
  if ( isConnected(elem1, elem2) ) ;
  return elem1.nod1.contains( elem2.node1 ) && elem1.nod2.contains( elem2.node2 ) || elem1.nod1.contains( elem2.node2 ) && elem1.nod2.contains( elem2.node1 );
}

boolean serie(CircElm elem1, CircElm elem2) {
  if ( isConnected(elem1, elem2) ) ;
  return elem1.nod1.contains( elem2.node1 ) || elem1.nod2.contains( elem2.node2 ) || elem1.nod1.contains( elem2.node2 ) || elem1.nod2.contains( elem2.node1 );
}

void setup() {
  size(800, 800);
  initializeElem();
  bt[0] = new Boton(color(0), 100, 100, "imgs/fuenteV.svg", 110, 95, 42, 70);
  bt[1] = new Boton(color(0), 100, 200, "imgs/resistencia.svg", 85, 205, 90, 45);
  bt[2] = new Boton(color(0), 100, 300, "imgs/cable.svg", 90, 305, 75, 45);
  bt[3] = new Boton(color(0), 100, 400, "imgs/resistencia.svg", 85, 205, 90, 45);
  bt[4] = new Boton(color(0), 100, 600, "imgs/trash.svg", 107, 605, 45, 50);
  c = 0;
  dash = new DashedLines(this);
  dash.pattern(10, 10);
}

void draw() {
  background(255);
  for ( int i = 0; i < 5; i++ ) {
    bt[i].draw();
    bt[i].overRect(mouseX, mouseY);
  }
  for ( CircElm e : elem ) {
    e.draw();
  }
  if (run) {
    dash.offset(dist);
    dist += 1;
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    for ( int i = 0; i < 3; i++ ) {
      if (bt[i].rectOver) {
        addElem(i);
      }
    }
  }
  if (mouseButton == LEFT) {
    for (int i=0; i<elem.size(); i++) {
      if (dist (mouseX, mouseY, elem.get(i).trans.x, elem.get(i).trans.y) <= 25) {
        elem.get(i).mov = true;
      }
      if (dist (mouseX, mouseY, elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y) <= 12) {
        elem.get(i).dragN1 = true;
      }
      if (dist (mouseX, mouseY, elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y) <= 12) {
        elem.get(i).dragN2 = true;
      }
      println(elem.get(i));
    }
  }
}

void mouseReleased() {
  idx = 0;
  for ( int i = 0; i < elem.size(); ++i ) {
    if ( elem.get(i).mov || elem.get(i).dragN1 || elem.get(i).dragN2) {
      idx = elem.get(i).id;
    }
    elem.get(i).mov = false;
    elem.get(i).dragN1 = false;
    elem.get(i).dragN2 = false;

    if (bt[4].rectOver) {
      if (dist(elem.get(i).trans.x, elem.get(i).trans.y, 150, 650)<=40) {
        if (elem.get(i).mov == false) {
          elem.remove(i);
        }
      }
    }
  }
  for ( CircElm c : elem )
    print(c.id + " ");

  temp = -1;
  for ( int i = 0; i < elem.size(); i++ )
    if ( elem.get(i).id == idx )
      temp = i;

  if ( temp == -1 ) {
    println( "El elemento no existe");
  } else {
    println( "La posicion del elemento es " + temp );

    for ( int i = 0; i < elem.size(); ++i ) {
      if ( elem.get(i).id == idx ) continue;
      if (dist( elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y, elem.get(temp).node2.posicion.x, elem.get(temp).node2.posicion.y) <= 30) {
        elem.get(i).node1.posicion.x = elem.get(temp).node2.posicion.x;
        elem.get(i).node1.posicion.y = elem.get(temp).node2.posicion.y;
        elem.get(i).nod1.add( elem.get( temp ).node2 ); //agrega posiciones
        elem.get(temp).nod2.add( elem.get( i ).node1 );
      }

      if (elem.get(i).nod1.contains(elem.get(temp).node2)&&elem.get(temp).nod2.contains(elem.get(i).node1)) {
        if (elem.get(i).node1.posicion.x != elem.get(temp).node2.posicion.x && elem.get(i).node1.posicion.y != elem.get(temp).node2.posicion.y) {
          elem.get(i).nod1.remove( elem.get( temp ).node2 );
          elem.get(temp).nod2.remove( elem.get( i ).node1 );
        }
      }

      //----------------------------------------------------------------------------------------------------------------------------------------------
      if (dist( elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y, elem.get(temp).node1.posicion.x, elem.get(temp).node1.posicion.y) <= 30) {
        elem.get(i).node1.posicion.x = elem.get(temp).node1.posicion.x;
        elem.get(i).node1.posicion.y = elem.get(temp).node1.posicion.y;
        elem.get(i).nod1.add( elem.get( temp ).node1 );
        elem.get(temp).nod1.add( elem.get( i ).node1 );
      } 
      if (dist( elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y, elem.get(temp).node1.posicion.x, elem.get(temp).node1.posicion.y) <= 30) {
        elem.get(i).node2.posicion.x = elem.get(temp).node1.posicion.x;
        elem.get(i).node2.posicion.y = elem.get(temp).node1.posicion.y;
        elem.get(i).nod2.add( elem.get( temp ).node1 );
        elem.get(temp).nod1.add( elem.get( i ).node2 );
      }
      if (dist( elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y, elem.get(temp).node2.posicion.x, elem.get(temp).node2.posicion.y) <= 30) {
        elem.get(temp).node2.posicion.x = elem.get(i).node2.posicion.x;
        elem.get(temp).node2.posicion.y = elem.get(i).node2.posicion.y;
        elem.get(i).nod2.add( elem.get( temp ).node2 );
        elem.get(temp).nod2.add( elem.get( i ).node2 );
      }
    }
  }
}

void mouseClicked() {
  if (bt[3].rectOver) {
    for ( CircElm c : elem )
      println(c.nod1 + "/" + c.nod2 + "de: " + c);
    run = !run;
    c = run ? 255 : 0;
  }
}