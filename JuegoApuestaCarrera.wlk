object consola {
    var property position = game.at(5,5)
    var property image = "fondoConsola1.png"
	
	method iniciar(){

		    game.width(29)
        game.height(12)
        game.boardGround("fondoConsola1.png")
        keyboard.q().onPressDo{self.iniciarAuto()}
        keyboard.w().onPressDo{self.iniciarMoto()}
        keyboard.e().onPressDo{self.iniciarCaballo()}
        game.start()
	}

	method iniciarAuto(){
		game.removeVisual("fondoConsola1.png")
		carreraAuto.iniciar()
	}
  method iniciarMoto(){
    game.removeVisual("fondoConsola1.png")
		carreraMoto.iniciar()
	}
  method iniciarCaballo(){
		game.removeVisual(self)
    game.removeVisual("fondoConsola1.png")
		carreraCaballo.iniciar()
	}
}

object carreraAuto {

  var property image = "game1.png"
  var property position = game.at(5,5)
   // const auto = new Autos(position = game.at(1,5), image = "moto.png")

  const autos = [new Autos(position = game.at(1,5), image = "auto.png"),
                new Autos(position = game.at(1,0), image = "auto2.png")]

  const obstaculos = [new Bloque(position = game.at(26,0), image = "bloque3.png"),
                      new Bloque(position = game.at(26,5), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    autos.forEach({a=>game.addVisual(a)})
    // game.addVisual(auto)
    autos.forEach({a=>a.arrancar()})
    // auto.arrancar()
    game.whenCollideDo(autos.first(),{a=>a.esChocadoPor(autos.first())} )
    game.start()
}


}

class Autos {

  var property position = game.at(1,0)
  var property image = "auto2.png"
  

  method arrancar(){
    game.onTick(500, "movimiento", {self.moverse()})
  }

  method chocar() {
    game.say(self, "auto ganador")
  }
  method moverse(){
    if ( position.x() >= 24 ) position = position.right(1) else { position = game.at( position.x()+(1..3).anyOne() , position.y() ) }
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
object carreraMoto {
  
  var property image = "game2.png"
  var property position = game.at(5,5)

  const motos = [new Motos(position = game.at(1,5), image = "moto.png"),
                new Motos(position = game.at(1,0), image = "moto.png")]

  const obstaculos = [new Bloque(position = game.at(26,0), image = "bloque3.png"),
                      new Bloque(position = game.at(26,5), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo2.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    motos.forEach({a=>game.addVisual(a)})
    motos.forEach({a=>a.arrancar()})
    game.whenCollideDo(motos,{a=>a.esChocadoPor(a)} )
    game.start()
}

}
class Motos inherits Autos {
  
}
object carreraCaballo {
  
  var property image = "game3.png"
  var property position = game.at(5,5)

  const caballos = [new Caballos(position = game.at(27,2), image = "caballos.png"),
                new Caballos(position = game.at(27,0), image = "caballos.png")]

  const obstaculos = [new Bloque(position = game.at(2,0), image = "bloque3.png"),
                      new Bloque(position = game.at(2,2), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo3.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    caballos.forEach({a=>game.addVisual(a)})
    caballos.forEach({a=>a.arrancar()})
    game.whenCollideDo(caballos,{a=>a.esChocadoPor(a)} )
    game.start()
}

}
class Caballos inherits Autos {
  override method moverse(){
    position = game.at( position.x()-(1..3).anyOne() , position.y() )
  }
}