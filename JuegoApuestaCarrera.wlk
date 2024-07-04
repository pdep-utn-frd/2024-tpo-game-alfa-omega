class Auto {
  
var property position = game.origin()
var property image
  

  method arrancar(){
    game.onTick(500, "movimiento", {self.moverse()})
  }
  method terminar() {
    if (position.x() == 3 ) game.stop()
  }
  method moverse(){
    position = game.at( position.x()+(1..3).anyOne() , position.y() )
    if (position.x() == 0)
    position = game.at(game.width()+1,position.y())
  }
  
}

object juego {
  const autos = [new Auto( position = game.at(1,5), image = "auto.png"), new Auto(position = game.at(1,0), image = "auto2.png")]


  method iniciar() {
    
    game.width(25)
    game.height(12)
    game.boardGround("fondo.png")
    autos.forEach({a=>game.addVisual(a)})
    autos.forEach({a=>a.arrancar()})
    

    game.start()
}


}