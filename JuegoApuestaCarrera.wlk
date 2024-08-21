object consola {
    var property position = game.at(5,5)
    var property image = "fondoConsola1.png"
    var monedas = 100
    var juegoActual = 0
	
	method iniciar(){

		    game.width(29)
        game.height(12)
        game.addVisual(fondo)
        game.boardGround("fondo.png")
        keyboard.q().onPressDo{self.cartel()}
        keyboard.r().onPressDo{self.reinicio()}
        keyboard.w().onPressDo{self.cartel2()}
        keyboard.e().onPressDo{self.cartel3()}
        game.start()
	}
  method iniciarAuto() {
    game.removeVisual(dragon)
		carreraAuto.iniciar()
    juegoActual = carreraAuto
    monedas = monedas - 50
  }
  method iniciarMoto() {
    game.removeVisual(dragon)
		carreraMoto.iniciar()
    juegoActual = carreraMoto
    monedas = monedas - 50
  }
  method iniciarCaballo() {
    game.removeVisual(dragon)
		carreraCaballo.iniciar()
    juegoActual = carreraCaballo
    monedas = monedas - 50
  }

  method reinicio() {
    game.addVisual(dragon)
    if ( monedas > 0 ) 
    keyboard.enter().onPressDo{juegoActual.reiniciar()}
    monedas = monedas - 50
  }

  	method cartel(){
    game.removeVisual(fondo)
    game.addVisual(dragon)
    keyboard.enter().onPressDo{self.iniciarAuto()}
	}
    	method cartel2(){
    game.removeVisual(fondo)
    game.addVisual(fondo2)
    game.addVisual(dragon)
    keyboard.enter().onPressDo{self.iniciarMoto()}
	}
    	method cartel3(){
    game.removeVisual(fondo)
    game.addVisual(fondo3)
    game.addVisual(dragon)
    keyboard.enter().onPressDo{self.iniciarCaballo()}
	}
}

object fondo {
   var property image = "fondoConsola.png"
  var property position = game.at(-2,0)
}
object fondo2 {
   var property image = "fondomotos.png"
  var property position = game.at(-2,0)
}
object fondo3 {
   var property image = "fondoCaballos.png"
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
class Motos inherits Autos {
  override method chocar() {
    game.say(self, "Moto ganadora")
  }
}
class Caballos inherits Autos {
  var cansado
  override method chocar() {
    game.say(self, "Caballo ganador")
  }
  method estaCansado() {
    if ( position.x() < 12 or position.x() > 20 ) cansado = true else cansado = false
  }
  override method moverse() {
     self.estaCansado()
     if ( position.x() >= 2 ) position = position.left(1) 
     else if (cansado) position = position.left(1) else
     { position = game.at( position.x()-(1..3).anyOne() , position.y() ) }
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

  const caballo = [new Caballos(posicionDePartida = game.at(26,0), cansado = true, position = game.at(26,0), image = "caballos.png"),
                new Caballos(posicionDePartida = game.at(26,5),cansado = true, position = game.at(26,5), image = "caballo2.png")]

  const obstaculos = [new Bloque(position = game.at(1,5), image = "bloque3.png"),
                      new Bloque(position = game.at(1,0), image = "bloque3.png")]

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

object carreraMoto {

  var property image = "game3.png"
  var property position = game.at(5,5)

  const motos = [new Motos(posicionDePartida = game.at(1,5), position = game.at(1,5), image = "moto.png"),
                new Motos(posicionDePartida = game.at(1,0),position = game.at(1,0), image = "moto.png")]

  const obstaculos = [new Bloque(position = game.at(26,0), image = "bloque3.png"),
                      new Bloque(position = game.at(26,5), image = "bloque3.png")]

  method iniciar() {
    
    game.width(29)
    game.height(12)
    game.boardGround("fondo2.png")
    obstaculos.forEach({a=>game.addVisual(a)})
    motos.forEach({a=>game.addVisual(a)})
    motos.forEach({a=>a.arrancar()})
    game.whenCollideDo(motos.first(),{a=>a.esChocadoPor(motos.first())} )
    game.start()
}

  method reiniciar() {

    motos.forEach({a=>game.removeVisual(a)})

    motos.forEach({a=>a.parar()})

    obstaculos.forEach({a=>game.removeVisual(a)})
    obstaculos.forEach({a=>game.addVisual(a)})

    motos.forEach({a=>game.addVisual(a)})

    motos.forEach({a=>a.arrancar()})

   game.whenCollideDo(motos.first(),{a=>a.esChocadoPor(motos.first())} )
}

}