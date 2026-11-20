import wollok.game.*
import panda.*
object contadorDeVidas{
        method image() = "contador_vida_" + (panda.vida()) + ".png" // Muestra la imagen del cartel de vidas
        method position() = game.at(0, 6)
}
//La superposición de ambos contadores no afecta la visualizacion de ninguno de ellos.
object cartelDePuntos{
        method image() = "cartel_de_puntos.png" // Muestra la imagen del cartel de puntos
        method position() = game.at(3, 6)
}
object contadorDepuntos {
        method image() = "contador_" + (panda.puntosSumados()) + ".png" // Muestra la imagen correspondiente a los puntos ganados por el panda
        method position() = game.at(4, 6)
}
object contadorDeComidasDesperdiciadas {
        method image() = "contador_comidas_desperdiciadas_" +(panda.comidasDesperdiciadas()) + ".png" // Muestra la imagen correspondiente a las comidas desperdiciadas por el panda
        method position() = game.at(4, 6)
}
