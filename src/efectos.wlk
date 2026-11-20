import sistemas.sistemaDeFondo.*

class Efecto {
    const property imagen
    const property pasos
    const property duracion
    method alAplicar() {}
}

object normal       inherits Efecto(imagen = "inicio",       pasos = 1,  duracion = 0) {}
object erratico     inherits Efecto(imagen = "exp_rojo",     pasos = 2,  duracion = 5000) {}
object desorientado inherits Efecto(imagen = "desorientado", pasos = -1, duracion = 5000) {}
object vestido      inherits Efecto(imagen = "con_ropa",     pasos = 1,  duracion = 10000) {}
object enfermo      inherits Efecto(imagen = "enfermo",      pasos = 0,  duracion = 5000) {}

object congelado inherits Efecto(imagen = "helado", pasos = 1, duracion = 10000) {
    override method alAplicar() { fondoNiveles.congelar(duracion) }
}