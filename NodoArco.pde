

class Nodo {
  int x, y, Id;
  color Color;
  boolean Marcado;
  boolean Vecino;
  //float ax, ay, vx, vy;
  ArrayList<Nodo> aristas = new ArrayList();
  Nodo(int x, int y) {
    this.x = x;
    this.y = y;
    this.Color = ColorNodoNormal;
    this.Marcado = false;
    this.Vecino = false;
    this.Id = CuantosNodosHay++;
  }
  void AgregarArista(Nodo Vecino) {
    aristas.add(Vecino);
    Vecino.aristas.add(this);
  } 
  void Eliminar() {
    if ( aristas.size()>1 ) {
      println("No se borra nodo con grado>1");
      return;
    }
    Nodo v = this.aristas.get(0);
    println("Borrando nodo "+this.Id+" conectado a "+v.Id);
    int iNodo = v.aristas.indexOf(this);
    v.aristas.remove(iNodo);
    v.Vecino = false;
    Nodos.remove(this.Id);
  }  
  boolean mouseIn() {
    if ( this.x-Radio/2<mouseX && mouseX<this.x+Radio/2  &&
         this.y-Radio/2<mouseY && mouseY<this.y+Radio/2 ) {
           return true;
    }
     return false;
  }
  void Mover(int x, int y) {
    if ( x<Radio ) 
        x = Radio+1;
    this.x = x;
    if ( y<Radio ) 
        y = Radio+1;
    if ( y > height-Radio )
        y = height-Radio-1;
    this.y = y;
  }
  void Dibujar() 
  {
    if ( !mouseIn() )
      noStroke();
    fill(this.Color);
    ellipse(x, y, Radio, Radio);
    stroke(25);
  }
  void Parpadeo() {
    for ( int i=0 ; i<5 ; i++ ) {
      fill(ColorPendiente);
      ellipse(x, y, Radio+5, Radio+5);
      delay(20);
      fill(ColorNoVisitado);
      ellipse(x, y, Radio+5, Radio+5);
      delay(20);
    }
      
  }
  void MostrarId() {
    textSize(SizeId);
    fill(0);
    text(str(this.Id),this.x+Radio/2,this.y-Radio/2);
  }
  void DibujarAristas() {
    stroke(150);
    for (Nodo Adjacentes : aristas) {
      if ( Adjacentes.Vecino && this.Vecino )
        stroke(ColorNodoVecino);
      else 
        stroke(150);
      line(x, y, Adjacentes.x, Adjacentes.y);
    }
  }
}
