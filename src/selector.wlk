import panda.*
import wollok.game.*

// Objeto que se encarga del selector de personaje
object selectorPersonaje {
    var property personajeElegido = pandaHombre
    var property position = game.at(1, 3) // Se posiciona una celda por arriba del panda masculino 

    method image() = "flecha_selector.png"

    method elegir(personaje, columna){
        personajeElegido = personaje
        position = game.at(columna, 3)
    }

    method elegirMasculino(){ 
        self.elegir(pandaHombre, 1) 
    }

    method elegirFemenino(){
        self.elegir(pandaMujer, 3)
    }
    
}