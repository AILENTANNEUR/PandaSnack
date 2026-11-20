import wollok.game.*
import panda.*
import sistemas.sistemaSonido.*
import niveles.*
import efectos.*

// Clase base para todas las comidas, define la posición, la caída y el efecto que tiene sobre el panda
class Comida{
    var property position
    
	method eventoDeCaida() = "caer_" + self.identity().toString()

	// Inicializa la comida para que caiga
    method initialize() {
		game.onTick(500, self.eventoDeCaida(), { self.caer() })
	}

    method caer(){
        if (position.y() > 0) { // Si la comida no ha llegado al piso, sigue cayendo
			position = position.down(1)
		} else {
			if (self.esBuena()){
			panda.sumaDeComidasDesperdiciadas()
		}
			self.destruir() // Deja de existir cuando toca el piso
		}
    }
    method esComidaPor(unPanda) {
		musica.sonidoComer()
		self.efecto(unPanda)
		unPanda.sumarPuntos(self.puntos())
		self.destruir()
		
	}
	// Elimina la comida, detiene su caída y la remueve del juego
	method destruir() {
		game.removeTickEvent(self.eventoDeCaida())
		game.removeVisual(self)
	}

    method efecto(unPanda) {}
	
	method puntos() = 1

	method esBuena(){
		return self.puntos() >= 1
	}
}
class ComidaMala inherits Comida {
	override method efecto(unPanda) {
		musica.sonidoComerMal()
		self.efectoEspecial(unPanda)
		unPanda.perderVida()
	}
	override method puntos() = -1

	method efectoEspecial(unPanda)
}
class Aji inherits ComidaMala {
    method image() = "Comida_aji.png"
	override method efectoEspecial(unPanda) {
		unPanda.aplicarEfecto(erratico)
	}
}

class Hongo inherits ComidaMala {
    method image() = "Comida_hongo.png"
	override method efectoEspecial(unPanda) {
		unPanda.aplicarEfecto(desorientado)
	}
	
}
class BambuPodrido inherits Comida {
	method image () = "Comida_Bambu_podrido.png"
	override method puntos() = 0 
	override method efecto(unPanda) {
		unPanda.aplicarEfecto(enfermo)
	}
}
class Dumpling inherits Comida {
    method image() = "Comida_dumpling.png"

	override method puntos() = 5

	override method efecto(unPanda) {
		unPanda.aplicarEfecto(vestido)
		
	}
}
class Bambu inherits Comida {
	method image() = "Comida_bambú.png"
}
class BubbleTee inherits Comida {
	method image() = "Comida_bubble_tee.png"

	override method puntos() = 2

	override method efecto(unPanda) {
		unPanda.aplicarEfecto(congelado) 
	}
}


// Se encarga de crear comidas aleatorias y agregarlas al juego
object fabricaDeComida {
    method crearComidaAleatoria() {
        const xAleatorio = 0.randomUpTo(game.width()).truncate(0)
        const yArriba = game.height() - 1
        const posicionAr = game.at(xAleatorio, yArriba)
        
        const probabilidad = 1.randomUpTo(101).truncate(0)
        const nuevaComida = self.determinarTipoDeComida(probabilidad, posicionAr)

        game.addVisual(nuevaComida)
    }
	// Determina el tipo de comida a crear según la probabilidad y el nivel actual
	method determinarTipoDeComida(probabilidad, posicion) {
		const nivel = controlDeNiveles.nivelActual() 

		const limiteBambu    = nivel.porcentajeBambu()
		const limiteDumpling = limiteBambu + (nivel.porcentajeDumpling()) 
		const limiteBubble   = limiteDumpling + 15     // 15 % fijo
		const limitePodrido  = limiteBubble + 5        // 5 % fijo
		const limiteAji      = (limitePodrido + 100) / 2  // el resto se reparte entre ají y hongo

		if (probabilidad <= limiteBambu) {
			return new Bambu(position = posicion)
		} else if (probabilidad <= limiteDumpling) {
			return new Dumpling(position = posicion)
		} else if (probabilidad <= limiteBubble) {
			return new BubbleTee(position = posicion)
		} else if (probabilidad <= limitePodrido) {
			return new BambuPodrido(position = posicion)
		} else if (probabilidad <= limiteAji) {
			return new Aji(position = posicion)
		} else {
			return new Hongo(position = posicion)
		}
	}
}