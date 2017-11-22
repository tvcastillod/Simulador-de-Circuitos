import garciadelcastillo.dashedlines.*;
import java.util.*;
import controlP5.*;

DashedLines dash;
float dist = 0;
int cont = 0;
int idx;
int temp;
int c;
boolean run = false;
ArrayList<CircElm> elem;
Boton[] bt;
IG ig;

void initializeElem() {
  bt = new Boton[7];
  ig = new IG();
  elem = new ArrayList<CircElm>();
}

void addElem( int i ) {
  CircElm newElem = null;
  if ( i == 0 ) newElem = new FuenteVolt(mouseX, mouseY, radians(270), mouseX, mouseY+45, mouseX, mouseY-45, cont); 
  if ( i == 1 ) newElem = new Resist(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont); 
  if ( i == 2 ) newElem = new Cable(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont);  
  if ( i == 3 ) newElem = new Amp(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont);  
  if ( i == 4 ) newElem = new Volt(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont);  
  elem.add( newElem );
  cont++;
}

boolean isConnected (CircElm elem1, CircElm elem2) {
  return elem1.nod1.contains( elem2.node1 ) || elem1.nod1.contains( elem2.node2 ) || elem2.nod1.contains( elem1.node1 ) || elem2.nod1.contains( elem1.node1 );
}

boolean serie(CircElm elem1, CircElm elem2) {
  if ( isConnected(elem1, elem2) ) ;
  return elem1.nod1.contains( elem2.node1 ) || elem1.nod2.contains( elem2.node2 ) || elem1.nod1.contains( elem2.node2 ) || elem1.nod2.contains( elem2.node1 );
}

void setup() {
  size(1400, 800);
  initializeElem();
  bt[0] = new Boton(color(0), 150, 230, "imgs/fuenteV.svg", 42, 70, "Fuente de Voltaje");
  bt[1] = new Boton(color(0), 150, 330, "imgs/resistencia.svg", 85, 45, "Resistencia");
  bt[2] = new Boton(color(0), 150, 430, "imgs/cable.svg", 60, 45, "Cable");
  bt[3] = new Boton(color(0), 150, 530, "imgs/amperimetro.svg", 62, 42, "Amperimetro");
  bt[4] = new Boton(color(0), 150, 630, "imgs/voltimetro.svg", 62, 46, "Voltimetro");
  bt[5] = new Boton(color(0), 1150, 200, "imgs/_.svg", 85, 45, "");
  bt[6] = new Boton(color(0), 1150, 690, "imgs/trash.svg", 45, 50, "");
  c = 0;
  dash = new DashedLines(this);
  dash.pattern(10, 10);
}

void draw() {
  background(240, 244, 250);
  if (run) {
    dash.offset(dist);
    dist -= 1;
    pushStyle();
    textSize(25);
    textAlign(LEFT, TOP); 
    fill(43, 180, 80);
    text("Conectado", 1120, 300);
    popStyle();
  } else {
    pushStyle();
    textSize(25);
    textAlign(LEFT, TOP); 
    fill(180, 40, 18);
    text("No se puede ejecutar", 1120, 300);
    popStyle();
  }
  ig.draw();
  for ( int i = 0; i < 7; i++ ) {
    bt[i].draw();
    bt[i].overRect(mouseX, mouseY);
  }
  for ( CircElm e : elem ) {
    e.draw();
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    for ( int i = 0; i < 5; i++ ) {
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

    if (bt[6].rectOver) {
      if (dist(elem.get(i).trans.x, elem.get(i).trans.y, bt[6].rectX, bt[6].rectY)<=40) {
        if (elem.get(i).mov == false) {
          elem.remove(i);
        }
      }
    }
  }
  //for ( CircElm c : elem )
  //print(c.id + " ");

  temp = -1;
  for ( int i = 0; i < elem.size(); i++ )
    if ( elem.get(i).id == idx )
      temp = i;

  if ( temp == -1 ) {
    //println( "El elemento no existe");
  } else {
    //println( "La posicion del elemento es " + temp );

    for ( int i = 0; i < elem.size(); ++i ) {
      if ( elem.get(i).id == idx ) continue;
      if (dist( elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y, elem.get(temp).node2.posicion.x, elem.get(temp).node2.posicion.y) <= 30) {
        elem.get(i).node1.posicion.x = elem.get(temp).node2.posicion.x;
        elem.get(i).node1.posicion.y = elem.get(temp).node2.posicion.y;
        if (!elem.get(i).nod1.contains( elem.get( temp ).node2 ) && !elem.get(temp).nod2.contains( elem.get( i ).node1 )) {
          elem.get(i).nod1.add( elem.get( temp ).node2 ); //agrega posiciones
          elem.get(temp).nod2.add( elem.get( i ).node1 );
        } else {
        }
      }
      if (elem.get(i).nod1.contains(elem.get(temp).node2) && elem.get(temp).nod2.contains(elem.get(i).node1)) {
        if (elem.get(i).node1.posicion.x != elem.get(temp).node2.posicion.x && elem.get(i).node1.posicion.y != elem.get(temp).node2.posicion.y) {
          elem.get(i).nod1.remove( elem.get( temp ).node2 );
          elem.get(temp).nod2.remove( elem.get( i ).node1 );
        }
      }

      //----------------------------------------------------------------------------------------------------------------------------------------------
      if (dist( elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y, elem.get(temp).node1.posicion.x, elem.get(temp).node1.posicion.y) <= 30) {
        elem.get(i).node1.posicion.x = elem.get(temp).node1.posicion.x;
        elem.get(i).node1.posicion.y = elem.get(temp).node1.posicion.y;
        if (!elem.get(i).nod1.contains( elem.get( temp ).node1 ) && !elem.get(temp).nod1.contains( elem.get( i ).node1 )) {
          elem.get(i).nod1.add( elem.get( temp ).node1 );
          elem.get(temp).nod1.add( elem.get( i ).node1 );
        } else {
        }
      } 

      if (elem.get(i).nod1.contains( elem.get( temp ).node1 ) && elem.get(temp).nod1.contains( elem.get( i ).node1 ) ) {
        if (elem.get(i).node1.posicion.x != elem.get(temp).node1.posicion.x && elem.get(i).node1.posicion.y != elem.get(temp).node1.posicion.y) {
          elem.get(i).nod1.remove( elem.get( temp ).node1 );
          elem.get(temp).nod1.remove( elem.get( i ).node1 );
        }
      }

      //----------------------------------------------------------------------------------------------------------------------------------------------
      if (dist( elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y, elem.get(temp).node1.posicion.x, elem.get(temp).node1.posicion.y) <= 30) {
        elem.get(i).node2.posicion.x = elem.get(temp).node1.posicion.x;
        elem.get(i).node2.posicion.y = elem.get(temp).node1.posicion.y;
        if (!elem.get(i).nod2.contains( elem.get( temp ).node1 ) && !elem.get(temp).nod1.contains( elem.get( i ).node2 )) {
          elem.get(i).nod2.add( elem.get( temp ).node1 );
          elem.get(temp).nod1.add( elem.get( i ).node2 );
        } else {
        }
      }

      if (elem.get(i).nod2.contains( elem.get( temp ).node1 ) && elem.get(temp).nod1.contains( elem.get( i ).node2 )) {
        if (elem.get(i).node2.posicion.x != elem.get(temp).node1.posicion.x && elem.get(i).node2.posicion.y != elem.get(temp).node1.posicion.y) {
          elem.get(i).nod2.remove( elem.get( temp ).node1 );
          elem.get(temp).nod1.remove( elem.get( i ).node2 );
        }
      }

      //---------------------------------------------------------------------------------------------------------------------------------------------
      if (dist( elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y, elem.get(temp).node2.posicion.x, elem.get(temp).node2.posicion.y) <= 30) {
        elem.get(temp).node2.posicion.x = elem.get(i).node2.posicion.x;
        elem.get(temp).node2.posicion.y = elem.get(i).node2.posicion.y;
        if ( !elem.get(i).nod2.contains( elem.get( temp ).node2 ) && !elem.get(temp).nod2.contains( elem.get( i ).node2 )) {
          elem.get(i).nod2.add( elem.get( temp ).node2 );
          elem.get(temp).nod2.add( elem.get( i ).node2 );
        } else {
        }
      }

      if (elem.get(i).nod2.contains( elem.get( temp ).node2 ) && elem.get(temp).nod2.contains( elem.get( i ).node2 )) {
        if (elem.get(temp).node2.posicion.x != elem.get(i).node2.posicion.x && elem.get(temp).node2.posicion.y != elem.get(i).node2.posicion.y) {
          elem.get(i).nod2.remove( elem.get( temp ).node2 );
          elem.get(temp).nod2.remove( elem.get( i ).node2 );
        }
      }
    }
  }
}

void mouseClicked() {
  int n = 0;
  if (bt[5].rectOver) {
    for ( CircElm c : elem )
      println(c.nod1 + "/" + c.nod2 + "de: " + c);
    for (int i = 0; i<elem.size(); i++) {
      if (elem.get(i).nod1.size() == 1 && elem.get(i).nod2.size() == 1) {
        n += 2;
      }
    }
  }
  if (n == 2*elem.size()) {
    run = true;
    println("Conectado");
  } else {
    run = false;      
    println("No se puede ejecutar");
  }
  c = run ? 255 : 0;
  println ("n= "+n);
  if (bt[6].rectOver) {
    elem.clear();
  }
}

// http://www.sojamo.de/libraries/controlP5/#examples