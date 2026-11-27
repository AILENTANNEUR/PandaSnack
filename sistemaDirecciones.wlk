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
    method siguiente(position) = tablero.validada(position.right(1), position)
    method opuesta() = izquierda
}
object izquierda {
    method siguiente(position) = tablero.validada(position.left(1), position)
    method opuesta() = derecha
}
