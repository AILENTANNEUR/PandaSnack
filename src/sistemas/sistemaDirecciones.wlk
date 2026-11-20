import wollok.game.*
// Objeto que representa el tablero del juego
object tablero {
    method dentro(position) {
        return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
    }
    method validada(nueva, actual) {
        if (!self.dentro(nueva)) {
            self.error("La posición está fuera del tablero")
        }
        return nueva
}
}

object derecha {
    method siguiente(position, pasos) = tablero.validada(position.right(pasos), position)
}
object izquierda {
    method siguiente(position, pasos) = tablero.validada(position.left(pasos), position)
}

