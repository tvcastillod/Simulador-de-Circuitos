import garciadelcastillo.dashedlines.*;
import java.util.*;
import controlP5.*;
import de.bezier.guido.*;

DashedLines dash;
float dist = 0;
float valueamp;
float valuevol;
int cont = 0;
int idx;
int idvol;
int temp;
int c;
boolean run = false;
ArrayList<CircElm> elem;
Boton[] bt;
IG ig;
ControlP5 val;
int pxr = 80;
int pxv = 80;
int num = 0;

void initializeElem() {
  bt = new Boton[7];
  ig = new IG();
  elem = new ArrayList<CircElm>();
  val = new ControlP5(this);
}

void addElem( int i ) {
  CircElm newElem = null;
  if ( i == 0 ) {
    newElem = new FuenteVolt(mouseX, mouseY, radians(270), mouseX, mouseY+45, mouseX, mouseY-45, cont, 10, "f");
    val.addSlider("V"+ num)
      .setSize(100, 15)
      .setPosition(pxv, 620)
      .setRange(-20, 20)
      .setValue(13)
      .setNumberOfTickMarks(41)
      .setColorCaptionLabel(0)
      .setSliderMode(Slider.FLEXIBLE)
      ;
  }
  if ( i == 1 ) {
    newElem = new Resist(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont, 100, "r");
    val.addSlider("R"+ num)
      .setSize(100, 15)
      .setPosition(pxr, 670)
      .setRange(0, 1000)
      .setValue(111)
      .setNumberOfTickMarks(101)
      .setColorCaptionLabel(0)
      .setSliderMode(Slider.FLEXIBLE)
      ;
  }
  if ( i == 2 ) newElem = new Cable(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont, 0,"c");  
  if ( i == 3 ) newElem = new Amp(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont, 0,"a");  
  if ( i == 4 ) newElem = new Volt(mouseX, mouseY, radians(180), mouseX-45, mouseY, mouseX+45, mouseY, cont, 0,"v");  
  elem.add( newElem );
  cont++;
}

boolean isConnected (CircElm elem1, CircElm elem2) {
  return elem1.nod1.contains( elem2.node1 ) || elem1.nod1.contains( elem2.node2 ) || elem2.nod1.contains( elem1.node1 ) || elem2.nod1.contains( elem1.node1 );
}

float equRes(ArrayList<CircElm> e){
  float reseq = 0;
  for(int i = 0; i < e.size(); i++){
    if(e.get(i).type == "r"){
      reseq += e.get(i).value;
    }  
  }
  return reseq;
}

float Current(ArrayList<CircElm> e, float reseq){
  float corr = 0;
  float volt = 0;
  for(int j = 0; j < e.size(); j++){
    if(e.get(j).type == "f"){
      volt += e.get(j).value;
    }  
  }
  if(reseq == 0){
    return corr = 0;
  }else{
    corr = volt/reseq;
  }
  return corr;
}


void setup() {
  size(1040, 700);
  reset();
}

void reset(){
  initializeElem();
  bt[0] = new Boton(color(0), 100, 160, "imgs/fuenteV.svg", 42, 70, "Fuente de Voltaje", 60);
  bt[1] = new Boton(color(0), 100, 260, "imgs/resistencia.svg", 85, 45, "Resistencia", 60);
  bt[2] = new Boton(color(0), 100, 360, "imgs/cable.svg", 60, 45, "Cable", 60);
  bt[3] = new Boton(color(0), 100, 460, "imgs/amperimetro.svg", 62, 42, "Amperimetro", 60);
  bt[4] = new Boton(color(0), 100, 560, "imgs/voltimetro.svg", 62, 46, "Voltimetro", 60);
  bt[5] = new Boton(color(0), 870, 160, "imgs/_.svg", 85, 45, "", 60);
  bt[6] = new Boton(color(0), 870, 560, "imgs/trash.svg", 45, 50, "", 60);
  c = 0;
  dash = new DashedLines(this);
  dash.pattern(10, 10);
}

void draw() {
  background(240, 244, 250);
  if (run) {
    dash.offset(dist);
    if(Current(elem, equRes(elem)) == 0){
      dist = 0;
    }else if(Current(elem, equRes(elem)) > 0){
      dist -= 10*Current(elem, equRes(elem));
    }else if(Current(elem, equRes(elem)) < 0){
      dist -= 10*Current(elem, equRes(elem));
    }
    pushStyle();
    textSize(19);
    textAlign(LEFT, TOP); 
    fill(43, 180, 80);
    text("Conectado", 840, 250);
    popStyle();
    println(equRes(elem));
    println(Current(elem, equRes(elem)));
    valueamp = Current(elem, equRes(elem));
  }else{
    pushStyle();
    textSize(19);
    textAlign(LEFT, TOP); 
    fill(180, 40, 18);
    text("No se puede ejecutar", 840, 250);
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
        if(i == 0) pxv += 120;
        if(i == 1) pxr += 120;
        num += 1;
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
      if (dist( elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y, elem.get(temp).node2.posicion.x, elem.get(temp).node2.posicion.y) <= 20) {
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
      if (dist( elem.get(i).node1.posicion.x, elem.get(i).node1.posicion.y, elem.get(temp).node1.posicion.x, elem.get(temp).node1.posicion.y) <= 20) {
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
      if (dist( elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y, elem.get(temp).node1.posicion.x, elem.get(temp).node1.posicion.y) <= 20) {
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
      if (dist( elem.get(i).node2.posicion.x, elem.get(i).node2.posicion.y, elem.get(temp).node2.posicion.x, elem.get(temp).node2.posicion.y) <= 20) {
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
  }else{
    run = false;      
    println("No se puede ejecutar");
  }
  c = run ? 255 : 0;
  println ("n= "+n);
  if (bt[6].rectOver) {
    elem.clear();
    reset();
  }
}

// http://www.sojamo.de/libraries/controlP5/#examples