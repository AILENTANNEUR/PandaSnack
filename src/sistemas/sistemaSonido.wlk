import wollok.game.*

// Objeto que se encarga de controlar la música del juego
object musica{
    const archivoMusica = "musica_snack.mp3"
    const volumenInicial = 0.5
    var property sonido = game.sound(archivoMusica)
    var property volumen = volumenInicial
    var property silenciada = false

    // Devuelve 0  si esta silenciada, sino devuelve el volumen elegido
    method volumenReal() = if (silenciada) 0 else volumen

    method reproducir(archivo){ 
        game.sound(archivo).play()
    }

    method iniciar() {
        sonido = game.sound(archivoMusica)
        sonido.shouldLoop(true)
        sonido.volume(self.volumen())
        game.schedule(100, { sonido.play() })

    }

    method detener() {
        if (sonido.played()) {
        sonido.stop()
        }
    }

    method reiniciar() {
        self.detener()
        silenciada = false
        volumen = volumenInicial
    }
    
    //Controlador de volumen
    method subirVolumen() {
        self.cambiarVolumen((volumen + 0.1).min(1))
    }

    method bajarVolumen() {
        self.cambiarVolumen((volumen - 0.1).max(0))
    }

    method cambiarVolumen(nuevo) {
        volumen = nuevo
        sonido.volume(self.volumenReal())
    }

    // Alternar silencio 
    method alternarSilencio() {
        silenciada = !silenciada // Cambia el estado de silencio
        sonido.volume(self.volumenReal()) // Actualiza el volumen del sonido según el estado de silencio
        }

    method configurarTeclas() {
        keyboard.up().onPressDo({ self.subirVolumen() })
        keyboard.down().onPressDo({ self.bajarVolumen() })
        keyboard.m().onPressDo({ self.alternarSilencio() })
    }
    
    method musicaGanar(){
        self.reproducir("musica_gana.mp3")
    }
    
    method musicaPerder(){
        self.reproducir("musica_pierde.mp3")
    }

    method sonidoComer(){
        self.reproducir("come.mp3")
    }
    method sonidoComerMal(){
        self.reproducir("no_quiere_comer.mp3")
    }

}