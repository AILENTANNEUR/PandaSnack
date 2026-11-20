import panda.*

object nivel {
    var property numeroDeNivel = 1

    method ticks(){
      return 2300 - ( 500 * numeroDeNivel )// 1800, 1300, 800
    }

    method puntosParaSubir() {
      return 10 * numeroDeNivel // 10, 20, 30
    }

    method porcentajeBambu() {
      return 45 - (5 * numeroDeNivel)// 40, 35, 30
    }

    method porcentajeDumpling() {
      return 12 - (3 * numeroDeNivel)// 9, 6, 3
    }

    method siguiente(){
      numeroDeNivel += 1 
    }

    method reiniciar(){ 
    numeroDeNivel = 1 
    }

    method esUltimo()  = numeroDeNivel == 3
    
}

object controlDeNiveles {
    method nivelActual() = nivel

    method ticksDeNivel() = nivel.ticks()

    method reiniciar() { nivel.reiniciar() }

    method proximoNivel() {
        if (!nivel.esUltimo() and panda.puntosSumados() >= nivel.puntosParaSubir()) {
            nivel.siguiente()
            console.println("Nivel " + nivel.numeroDeNivel())
        }
    }
}