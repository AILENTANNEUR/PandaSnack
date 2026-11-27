import panda.*

class Nivel {
    const property numeroDeNivel
    const property ticks
    const property puntosParaSubir
    const property porcentajeBambu
    const property porcentajeDumpling

    // Cada nivel decide cuál es el que sigue
    method siguiente()

    method puedeSubir(puntos) = puntos >= puntosParaSubir
}

object nivel1 inherits Nivel(numeroDeNivel = 1, ticks = 1800, puntosParaSubir = 10, porcentajeBambu = 40, porcentajeDumpling = 9) {
    override method siguiente() = nivel2
}

object nivel2 inherits Nivel(numeroDeNivel = 2, ticks = 1300, puntosParaSubir = 20, porcentajeBambu = 35, porcentajeDumpling = 6) {
    override method siguiente() = nivel3
}

object nivel3 inherits Nivel(numeroDeNivel = 3, ticks = 800, puntosParaSubir = 30, porcentajeBambu = 30, porcentajeDumpling = 3) {
    // Último nivel
    override method siguiente() = self
    override method puedeSubir(puntos) = false
}

object controlDeNiveles {
    var actual = nivel1

    method nivelActual() = actual
    method ticksDeNivel() = actual.ticks()

    method reiniciar() {
        actual = nivel1
    }

    method proximoNivel() {
        if (actual.puedeSubir(panda.puntosSumados())) {
            actual = actual.siguiente()
            console.println("Nivel " + actual.numeroDeNivel())
        }
    }
}