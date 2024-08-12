object consola {
    var property position = game.at(5,5)
    var property image = "fondoConsola1.png"
    var monedas = 100
	
	method iniciar(){

		    game.width(29)
        game.height(12)
        game.addVisual(fondo)
        game.boardGround("fondo.png")
        keyboard.q().onPressDo{self.cartel()}
        keyboard.r().onPressDo{self.reinicio()}
//       keyboard.w().onPressDo{self.iniciarMoto()}
//       keyboard.e().onPressDo{self.iniciarCaballo()}
        game.start()
	}
  method iniciarAuto() {
    game.removeVisual(dragon)
		carreraAuto.iniciar()
    monedas = monedas - 50
  }

  method reinicio() {
    game.addVisual(dragon)
    if ( monedas > 0 ) 
    keyboard.enter().onPressDo{carreraAuto.reiniciar()}
    monedas = monedas - 50
  }

	method cartel(){
    game.removeVisual(fondo)
    game.addVisual(dragon)
    keyboard.enter().onPressDo{self.iniciarAuto()}
	}
//  method iniciarMoto(){
//		carreraMoto.iniciar()
//	}
//  method iniciarCaballo(){
//		carreraCaballo.iniciar()
//	}
}

object fondo {
   var property image = "fondoConsola.png"
  var property position = game.at(-2,0)
}

object dragon {
   var property image = "dragon.png"
  var property position = game.at(5,2)
}

object carreraAuto {

  var property image = "game1.png"
  var property position = game.at(5,5)

  const autos = [new Autos(posicionDePartida = game.at(1,5), position = game.at(1,5), image = "auto.png"),
                new Autos(posicionDePartida = game.at(1,0),position = game.at(1,0), image = "auto2.png")]

  const obstaculos = [new Bloque(position = game.at(26,0), image = "bloque3.png"),
                      new Bloque(position = game.at(26,5), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    autos.forEach({a=>game.addVisual(a)})
    autos.forEach({a=>a.arrancar()})
    game.whenCollideDo(autos.first(),{a=>a.esChocadoPor(autos.first())} )
    game.start()
}

  method reiniciar() {

    autos.forEach({a=>game.removeVisual(a)})

    autos.forEach({a=>a.parar()})

    obstaculos.forEach({a=>game.removeVisual(a)})
    obstaculos.forEach({a=>game.addVisual(a)})

    autos.forEach({a=>game.addVisual(a)})

    autos.forEach({a=>a.arrancar()})

   game.whenCollideDo(autos.first(),{a=>a.esChocadoPor(autos.first())} )
}

}

class Autos {

  var property position = game.at(1,0)
  var property image = "auto2.png"
  var posicionDePartida

  method arrancar(){
    game.onTick(500, "movimiento", {self.moverse()})
  }

  method parar() {
   position = posicionDePartida
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

object carreraCaballo {

  var property image = "game3.png"
  var property position = game.at(5,5)

  const caballo = [new Caballos(posicionDePartida = game.at(1,5), position = game.at(1,5), image = "caballo.png"),
                new Caballos(posicionDePartida = game.at(1,0),position = game.at(1,0), image = "caballo2.png")]

  const obstaculos = [new Bloque(position = game.at(26,0), image = "bloque3.png"),
                      new Bloque(position = game.at(26,5), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo3.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    caballo.forEach({a=>game.addVisual(a)})
    caballo.forEach({a=>a.arrancar()})
    game.whenCollideDo(caballo.first(),{a=>a.esChocadoPor(caballo.first())} )
    game.start()
}

  method reiniciar() {

    caballo.forEach({a=>game.removeVisual(a)})

    caballo.forEach({a=>a.parar()})

    obstaculos.forEach({a=>game.removeVisual(a)})
    obstaculos.forEach({a=>game.addVisual(a)})

    caballo.forEach({a=>game.addVisual(a)})

    caballo.forEach({a=>a.arrancar()})

   game.whenCollideDo(caballo.first(),{a=>a.esChocadoPor(caballo.first())} )
}

}

class Caballos inherits Autos {
}