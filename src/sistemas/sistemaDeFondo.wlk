import wollok.game.*
import niveles.*

// Se encarga de controlar la iteracion de los niveles y el fondo correspondiente a cada nivel
object fondoNiveles{ 
    var congelamientos = 0   // Cuantos bubble tea "activos" hay

    method position() = game.at(0, 0)

    method congelado() = congelamientos > 0
 
   // Devuelve la imagen correspondiente al nivel actual y si esta congelado o no
    method image() {
        const prefijo = if (self.congelado()) "fondo_nivel_congelado_" else "fondo_nivel_" 
        return prefijo + controlDeNiveles.nivelActual().numeroDeNivel() + ".png" 
    }

    // Congela el fondo del juego por la cantidad de milisegundos especificada
    method congelar(milisegundos) {
        congelamientos += 1
        game.schedule(milisegundos, { self.descongelar() })
    }

    method descongelar() {
        congelamientos = (congelamientos - 1).max(0)
    }

    method reiniciar() {
        congelamientos = 0
    }

    method esComidaPor(unPanda) { }

}

class Fondo {
    const property image
    method position() = game.at(0, 0)
}

const tutorial      = new Fondo(image = "tutorial.png")
const fondoSelector = new Fondo(image = "menu_con_selector.png")
const fondoGameOver = new Fondo(image = "game_over.png")
const fondoGanar    = new Fondo(image = "snack_ganaste.png")
const fondoInicio   = new Fondo(image = "pantalla_inicio.png")