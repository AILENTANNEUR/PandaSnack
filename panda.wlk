import panda_snack.*
import wollok.game.*
import efectos.*
import niveles.*

object panda {
    const vidaInicial = 3
    const posicionInicial = game.at(2, 0)
    const puntosParaGanar = 30
    const maxDesperdicio = 5

    var property position = posicionInicial
    var property genero = pandaHombre
    var property puntosSumados = 0
    var property comidasDesperdiciadas = 0
    var vida = vidaInicial
    var estado = normal
    var contadorDeEfectos = 0

    method image() = genero.prefijo() + estado.imagen() + ".png"
    method vida() = vida

    // Movimiento: la cantidad de pasos la decide el estado actual
    method mover(direccion) {
        position = direccion.siguiente(position, estado.pasos())
    }

    // Puntos y vidas
    method sumarPuntos(puntos) {
        puntosSumados = 0.max(puntosSumados + puntos)
        if (puntosSumados >= puntosParaGanar) {
            pandaSnack.finalizarSiGana(self)
        }
    }

    method perderVida() {
        vida = (vida - 1).max(0)
        if (vida == 0) {
            pandaSnack.finalizarSiPierde(self)
        }
    }

    method sumaDeComidasDesperdiciadas() {
        comidasDesperdiciadas += 1
        if (comidasDesperdiciadas >= maxDesperdicio) {
            pandaSnack.finalizarSiPierde(self)
        }
    }

    // Estados temporales
    method aplicarEfecto(efectoNuevo) {
        estado = efectoNuevo
        efectoNuevo.alAplicar()
        self.programarVueltaALaNormalidad(efectoNuevo.duracion())
    }

    // Si el panda tiene varios efectos aplicados, solo vuelve a la normalidad cuando se cumpla el tiempo del último efecto aplicado
      method programarVueltaALaNormalidad(milisegundos) {
        contadorDeEfectos += 1
        const cantDeEfectos = contadorDeEfectos
        game.schedule(milisegundos, {
            if (cantDeEfectos == contadorDeEfectos) { self.volverALaNormalidad() }
        })
    }

    method volverALaNormalidad() {
        estado = normal
    }

    method reiniciarPanda() {
        vida = vidaInicial
        puntosSumados = 0
        position = posicionInicial
        comidasDesperdiciadas = 0
        self.volverALaNormalidad()
    }
}
object pandaHombre {
    method prefijo() = "panda_"
}

object pandaMujer {
    method prefijo() = "panda_mujer_"
}