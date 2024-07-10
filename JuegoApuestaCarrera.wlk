object consola {
    var property position = game.origin()
	
	method iniciar(){
		    game.width(29)
        game.height(12)
        game.boardGround("fondoMenu.png")
       // game.addVisual(carreraAuto)
       // game.addVisual(cursor)
       // game.addVisual(carreraCaballo)
        // game.addVisual(carreraMoto)
       keyboard.enter().onPressDo{self.hacerIniciar(juego)}
	      keyboard.right().onPressDo{cursor.moverderecha()}
		    keyboard.left().onPressDo{cursor.moverizquierda()}
	}
	
	method hacerIniciar(juego){
		game.clear()
		juego.iniciar()
  
	}
 
  
}

object cursor {
  var property position = game.origin()
  var property image = "cursor.png"

   method moverizquierda() {
    
    position = position.left(1)
  }

  method moverderecha() {
    position = position.right(1)
  }
}

object carreraAuto {
  var property image = "game1.png"
  var property position = game.at(5,5)

  const obstaculos = [new Bloque(position = game.at(15,0), image = "bloque3.png"),
                      new Bloque(position = game.at(15,5), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    game.addVisual(auto)
    game.addVisual(auto2)
    auto.arrancar()
    game.whenCollideDo(auto,{a=>a.esChocadoPor(auto)} )
    auto2.arrancar()
    game.whenCollideDo(auto2,{a=>a.esChocadoPor(auto2)})
    game.start()
}


}

object auto {
  
var property position = game.at(1,5)
var property image = "auto.png"
  

  method arrancar(){
    game.onTick(500, "movimiento", {self.moverse()})
  }

  method chocar() {
    game.say(self, "auto ganador")
  }
  method moverse(){
    position = game.at( position.x()+(1..3).anyOne() , position.y() )
    if (position.x() == 0)
    position = game.at(game.width()+1,position.y())
  }
  
}

object auto2 {
  
var property position = game.at(1,0)
var property image = "auto2.png"
  

  method arrancar(){
    game.onTick(500, "movimiento", {self.moverse()})
  }

  method chocar() {
    game.say(self, "auto ganador")
  }
  method moverse(){
    position = game.at( position.x()+(1..3).anyOne() , position.y() )
    if (position.x() == 0)
    position = game.at(game.width()+1,position.y())
  }
  
}

class Bloque {
  var property position = game.at(5,5)
  var property image
  var fuechocado = false

  method esChocadoPor(unAuto) {
    if (  not fuechocado ) {
    unAuto.chocar()
    game.removeVisual(self) 
    fuechocado = true } 
    
  }
}
object carreraMoto inherits carreraAuto {
  var property image = "game2.png"
  var property position = game.origin() 

  method iniciar() {
   game.width(29)
    game.height(12)
    game.boardGround("fondo.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    game.addVisual(auto)
    game.addVisual(auto2)
    auto.arrancar()
    game.onCollideDo(auto,{a=>a.esChocadoPor(auto)} )
    auto2.arrancar()
    game.onCollideDo(auto2,{a=>a.esChocadoPor(auto2)})
    
    game.start()

}
}
object moto inherits auto {

}

object moto2 inherits auto2 {

}

object carreraCaballo inherits carreraAuto {
  var property image = "game3.png"
  var property position = game.origin() 
}
object caballo inherits auto {
  
}

object caballo2 inherits auto2 {

}