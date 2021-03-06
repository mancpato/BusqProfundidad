/* 
    Para mostrar recorridos en espacios de búsqueda
    
    Búsqueda en Profundidad simple. 
    Al encontrar el nodo objetivo se detiene.
        
    Miguel Angel NOrzagaray Cosío

    UABCS/DSC
*/

import java.util.Stack;

int RadioMin = 10, RadioMax = 20;
int Radio = 10;
boolean MostrarId = false;
boolean Buscando = false;

int Divisiones=20;

int AnchoPincel = 2;
int SizeId = 12;

int Tabulador = 8;

color ColorFondo = 240;

color colorNodoMeta = #FF00FF;

// Para la edición inicial
color ColorNodoNormal = #8080FF;
color ColorNodoTocado = #0000FF;
color ColorNodoMarcado = #80FF80;
color ColorNodoMarcadoTocado = #00FF00;
color ColorNodoVecino = #FF8000;

// Para el recorrido
color ColorNoVisitado = #0000FF;
color ColorPendiente = #00FF00;
color ColorVisitado = #FFFF00;
color ColorCamino = #F000F0;

color ColorAristaNormal = 150;
color COlorAristaAdyacente = 50;

int NodosMarcados = 0;
boolean MoviendoNodo = false;
boolean MarcandoNodos = false;

Nodo NodoEnMovimiento;
Nodo NodoMarcado1, NodoMarcado2;

int CuantosNodosHay = 0;

ArrayList<Nodo> Nodos = new ArrayList();
Stack<Nodo> Pila = new Stack<Nodo>();

void setup()
{
    size(800,600);
    
    MkGrafo();
}

void draw()
{
    background(ColorFondo);
    cursor(CROSS);
    strokeWeight(AnchoPincel);
  
    for (Nodo n : Nodos) 
        n.DibujarAristas();
  
    if ( !Buscando ) {
        for (Nodo n : Nodos) {
            if ( MostrarId )
                n.MostrarId();
            if ( n.mouseIn()==true ) {
                n.Color = n.Marcado ? ColorNodoMarcadoTocado : ColorNodoTocado;
                n.MostrarId();
            } else
                n.Color = n.Marcado ? ColorNodoMarcado : ColorNodoNormal;
            if ( n.Vecino == true )
                n.Color = ColorNodoVecino;
        }

        // Aquí inicia el algoritmo de búsqueda en profundidad
        if ( NodosMarcados == 1 && key == ' ' ) {
            Buscando = true;
            for (Nodo n : Nodos) {
                n.Color = ColorNoVisitado;
                n.Marcado = n.Vecino = false;
            }
            Pila.push( NodoMarcado1 );
            //noLoop();
        }
    } else {
        // Iteraciones de la búsqueda en profundidad
        Nodo u;
        if ( !Pila.isEmpty() && key==' ' ) {
            u = Pila.pop();
            for ( Nodo v : u.aristas ) {
                if ( v.Color  == ColorNoVisitado ) {
                    v.Color = ColorPendiente;
                    Pila.add(v);
                }
            }
            u.Color = ColorVisitado;
        }
    }
    for (Nodo n : Nodos)
        n.Dibujar();
}

void MkGrafo()
{
    int rmin,rmax;
    Nodo n,v;
    
    int T = height/Divisiones;
    int M = 5;  // Desorden
      
    for ( int i=0 ; i<Divisiones ; i++ )
        for ( int j=0 ; j<Divisiones ; j++ ) {
              n = new Nodo( int(j*T+T/2+random(-T/M,T/M)),      // Columna
                            int(i*T+T/2+random(-T/M,T/M)) );    // Fila
              Nodos.add(n);
              if ( random(50)<1 )
                n.Color = colorNodoMeta;
        }
    rmin = 2;
    rmax = 3;
    for ( int i=1 ; i<Divisiones ; i++ )
        for ( int j=1 ; j<Divisiones ; j++ ) {
            n = Nodos.get(i*Divisiones+j);
            
            if ( random(rmin) < random(rmax) ) {
                v = Nodos.get(i*Divisiones+j-1);
                n.AgregarArista(v);
            }

            if ( random(rmin) < random(rmax) ) {
                v = Nodos.get((i-1)*Divisiones+j);
                n.AgregarArista(v);
            }
        }
      
    rmin = 5;
    rmax = 3;
    for ( int i=1 ; i<Divisiones-1 ; i++ )
        for ( int j=1 ; j<Divisiones-1 ; j++ ) {
            n = Nodos.get(i*Divisiones+j);

            if ( random(rmin) < random(rmax) ) {
                v = Nodos.get((i-1)*Divisiones+j-1);
                n.AgregarArista(v);
            }
            /*if ( random(rmin) < random(rmax) ) {
                v = Nodos.get((i-1)*Divisiones+j+1);
                n.AgregarArista(v);
            }*/
            if ( random(rmin) < random(rmax) ) {
                v = Nodos.get((i+1)*Divisiones+j-1);
                n.AgregarArista(v);
            }
            /*if ( random(rmin) < random(rmax) ) {
                v = Nodos.get((i+1)*Divisiones+j+1);
                n.AgregarArista(v);
            }*/
        }
  
    rmin = 2;
    rmax = 4;
    for ( int i=1 ; i<Divisiones ; i++ ) {
        n = Nodos.get(i);
        if ( random(rmin) < random(rmax) ) {
            v = Nodos.get(i-1);
            n.AgregarArista(v);
        }
        n = Nodos.get(i*Divisiones);
        if ( random(rmin) < random(rmax) ) {
            v = Nodos.get((i-1)*Divisiones);
            n.AgregarArista(v);
        }
    }
}

void draw()
{
    background(ColorFondo);
    cursor(CROSS);
    strokeWeight(AnchoPincel);
  
    for (Nodo n : Nodos) 
        n.DibujarAristas();
  
    if ( !Buscando ) {
        for (Nodo n : Nodos) {
            if ( MostrarId )
                n.MostrarId();
            if ( n.mouseIn()==true ) {
                if ( n.Color != colorNodoMeta )
                    n.Color = n.Marcado ? 
                        ColorNodoMarcadoTocado : ColorNodoTocado;
                n.MostrarId();
            } else
                if ( n.Color != colorNodoMeta )
                  n.Color = n.Marcado ? 
                    ColorNodoMarcado : ColorNodoNormal;
            if ( n.Vecino == true )
                if ( n.Color != colorNodoMeta )
                    n.Color = ColorNodoVecino;
        }

        // Aquí inicia el algoritmo de búsqueda en profundidad
        if ( NodosMarcados > 0  &&  key == ' ' ) {
            Buscando = true;
            for (Nodo n : Nodos) {
                if ( n.Color != colorNodoMeta )
                  n.Color = ColorNoVisitado;
                n.Marcado = n.Vecino = false;
            }
            Pila.push( NodoMarcado1 );
        }
    } else {
        // Iteraciones de la búsqueda en profundidad
        Nodo u;
        if ( !Pila.isEmpty() && key==' ' ) {
            u = Pila.pop();
            for ( Nodo v : u.aristas ) {
                if ( v.Color == colorNodoMeta ) {
                    v.padre = u;
                    ObjetivoEncontrado(v);
                }
                if ( v.Color  == ColorNoVisitado ) {
                    v.Color = ColorPendiente;
                    v.padre = u;
                    Pila.add(v);
                }
            }
            u.Color = ColorVisitado;
            //noLoop();
        }
    }
    for (Nodo n : Nodos)
        n.Dibujar(); //<>//
}

void ObjetivoEncontrado(Nodo p)
{
    fill(0);
    textSize(24);
    text("¡Nodo objetivo", 620, 50);
    text("encontrado!", 620, 80);
    noStroke();
    fill(ColorCamino);
    circle(p.x, p.y, Radio+5);
    print("p="+p.Id);
    while ( p.padre != null ) {
      fill(ColorCamino);
      circle(p.x, p.y, Radio+5);
      p.MostrarId();
      print(" -> "+p.padre.Id);
      p = p.padre;
    }
    p.Color = colorNodoMeta;
    p.Dibujar();
    noFill();
    circle(p.x, p.y, Radio+5);
    p.MostrarId();
    noLoop();
}

void mouseClicked()
{
  Nodo n = null;

  // Nuevo nodo o arista
  if ( mouseButton == RIGHT ) {
    if ( Buscando ) {
      redraw();
      return;
    }
    
    // Mouse sobre un nodo: no se agrega nada
    for ( Nodo a : Nodos ) 
      if ( a.mouseIn() )
        return;
    
    if ( NodosMarcados == 2 ) {
      
        if ( NodoMarcado1.aristas.contains(NodoMarcado2) ) {
            println(NodoMarcado1.Id+" y "+NodoMarcado2.Id+" son adyacentes");
            return;
        }
        NodoMarcado1.AgregarArista(NodoMarcado2);
        println("Se agrega arista entre "+NodoMarcado1.Id+" y "+NodoMarcado2.Id);
    }
  
  } else { // Botón izquierdo: marcar
    if ( Buscando ) {
      redraw();
      return;
    }
    for ( Nodo a : Nodos) {
      if ( a.mouseIn() ) {
        n = a;
        break;
      }
    }
    if ( n == null )
      return;

    switch ( NodosMarcados ) {
      case 0:
        NodosMarcados = 1;
        NodoMarcado1 = n;
        for ( Nodo v : n.aristas )
          v.Vecino = true;
        break;
      case 1: 
        // Click sobre nodo marcado lo desmarca
        if ( NodoMarcado1 == n ) {
          NodosMarcados = 0;
          for ( Nodo v : n.aristas )
            v.Vecino = false;
        } else {
          NodoMarcado2 = n;
          NodosMarcados = 2;
          NodoMarcado2.Vecino = false;
        }
        break;
      case 2:
        // Click sobre nodo marcado lo desmarca
        if ( NodoMarcado1 == n ) {
          NodosMarcados = 1;
          for ( Nodo v : NodoMarcado1.aristas )
            v.Vecino = false;
          for ( Nodo v : NodoMarcado2.aristas )
            v.Vecino = true;
          NodoMarcado1 = NodoMarcado2;
          NodoMarcado2 = null;
        } else if ( NodoMarcado2 == n ) {
          NodosMarcados = 1;
          for ( Nodo v : NodoMarcado2.aristas )
            v.Vecino = false;
          for ( Nodo v : NodoMarcado1.aristas )
            v.Vecino = true;
          NodoMarcado2 = null;
        } else {
          NodoMarcado1.Marcado = false;
          for ( Nodo v : NodoMarcado1.aristas )
            v.Vecino = false;
          NodoMarcado1.Color = ColorNodoNormal;
          NodoMarcado1 = NodoMarcado2;
          NodoMarcado2 = n;
        }
        break;
      } // switch

      n.Marcado = !n.Marcado;
      n.Color = n.Marcado ? ColorNodoMarcado : ColorNodoNormal;
  } // Botón izquierdo
  
} // mouseClicked

void mouseDragged() 
{
  if ( MoviendoNodo == false  &&  mouseButton == LEFT ) {
    for (Nodo n : Nodos) {
      if ( n.mouseIn()==true ) {
        MoviendoNodo = true;
        NodoEnMovimiento = n;
      }
    }
  }
  if (MoviendoNodo == true )
    NodoEnMovimiento.Mover(mouseX,mouseY);
}

void mouseReleased() 
{
  MoviendoNodo = false;
  NodoEnMovimiento = null;
}

void mouseWheel(MouseEvent event) 
{
  float e = event.getCount();

  Radio += e;
  if ( Radio < RadioMin )
      Radio = RadioMin;
  if ( Radio > RadioMax )
      Radio = RadioMax;
}

/* Fin de archivo */
