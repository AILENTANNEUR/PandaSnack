import wollok.game.*
import panda.*
import sistemaSonido.*
import sistemaDeFondo.*
import sistemaDirecciones.*
import comidas.*
import puntos.*
import niveles.*
import selector.*

object pandaSnack {

    //Pantalla de inicio del juego (nombre del juego y los participantes)
    method pantallaInicial() {
        game.clear()
        game.boardGround(fondoInicio.image())
        keyboard.enter().onPressDo({
            self.pantallaDeSeleccion()
            console.println("Iniciando el juego de la comida...")
        })
    }
    
    // Pantalla para decidir personaje y empezar
    method pantallaDeSeleccion() {
        game.clear()
        game.addVisual(fondoSelector)
        musica.iniciar()
        selectorPersonaje.elegirMasculino() // Arranca apuntando al Panda masculino por defecto
        game.addVisual(selectorPersonaje)

        keyboard.left().onPressDo({ 
            selectorPersonaje.elegirMasculino()
        })
        keyboard.right().onPressDo({
            selectorPersonaje.elegirFemenino()
        })
        keyboard.enter().onPressDo({
            panda.genero(selectorPersonaje.personajeElegido())
            self.pantallaDelTutorial()
        })
    }
    
    // Pantalla del tutorial del juego
    method pantallaDelTutorial() {
        game.clear()
        game.addVisual(tutorial)
        keyboard.enter().onPressDo({self.iniciarJuego()}) 
    }

    // Inicia el juego, reinicia el panda, llama al metodo para configurar el teclado y programa la aparición de la siguiente comida
    method iniciarJuego() {
        game.clear()
        self.configurarTeclado()
        self.visual()
        self.programarSiguienteComida()
        game.onCollideDo(panda, { comida => comida.esComidaPor(panda) 
                                            controlDeNiveles.proximoNivel()})
    }

    // Muestra los elementos visuales del juego ( el fondo, el panda, carteles de puntos, cartel de vidas y los contadores)
    method visual(){
        game.addVisual(fondoNiveles)
        game.addVisual(panda)
        game.addVisual(contadorDeVidas)
        game.addVisual(contadorDepuntos)
        game.addVisual(contadorDeComidasDesperdiciadas)
        game.addVisual(cartelDePuntos)
        
    }

    // Configura el teclado para mover al panda
    method configurarTeclado(){
        keyboard.left().onPressDo({panda.mover(izquierda)})
        keyboard.right().onPressDo({panda.mover(derecha)})
        musica.configurarTeclas()
    }

    // Programa la aparición de la siguiente comida
    method programarSiguienteComida() {
        game.schedule(controlDeNiveles.ticksDeNivel(), {  
            fabricaDeComida.crearComidaAleatoria() 
            self.programarSiguienteComida() // Se reprograma con la velocidad actual
        })
    }

    // Reinicia el juego después de perder o ganar
    method reiniciarJuego() {
        game.clear()
        try {musica.detener()} catch e : Exception {}
        musica.reiniciar()
        game.boardGround(fondoInicio.image())
        keyboard.enter().onPressDo({
            self.pantallaDeSeleccion()
            console.println("Iniciando el juego de la comida...")
        })
        fondoNiveles.reiniciar()
        panda.reiniciarPanda()
        controlDeNiveles.reiniciar()
    }

    // Finaliza el juego mostrando la pantalla de Game Over o de Victoria, deteniendo la música y configurando el teclado para reiniciar el juego
    method finalizar(fondo, sonidoFinal) {
        game.clear()
        game.addVisual(fondo)
        musica.detener()
        console.println("Juego terminado")
        sonidoFinal.apply()
        keyboard.enter().onPressDo({ self.reiniciarJuego() })
    }

    method finalizarSiPierde(_){
        self.finalizar(fondoGameOver, { musica.musicaPerder() }) 
    }
    
    method finalizarSiGana(_){
        self.finalizar(fondoGanar,    { musica.musicaGanar() }) 
    }

}




        





