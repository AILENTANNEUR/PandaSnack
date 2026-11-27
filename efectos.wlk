import sistemaDeFondo.*

class Efecto {
    const property imagen
    const property duracion
    method alAplicar() {}

    // Por defecto: un paso en la dirección pedida
    method desplazar(direccion, position) = direccion.siguiente(position)
}

object normal inherits Efecto(imagen = "inicio", duracion = 0) {}

object vestido inherits Efecto(imagen = "con_ropa", duracion = 10000) {}

object erratico inherits Efecto(imagen = "exp_rojo", duracion = 5000) {
    override method desplazar(direccion, position) =
        direccion.siguiente(direccion.siguiente(position))
}

object desorientado inherits Efecto(imagen = "desorientado", duracion = 5000) {
    override method desplazar(direccion, position) =
        direccion.opuesta().siguiente(position)
}

object enfermo inherits Efecto(imagen = "enfermo", duracion = 5000) {
    override method desplazar(direccion, position) = position
}

object congelado inherits Efecto(imagen = "helado", duracion = 10000) {
    override method alAplicar() { fondoNiveles.congelar(duracion) }
}