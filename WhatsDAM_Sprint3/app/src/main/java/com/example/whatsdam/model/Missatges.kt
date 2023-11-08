package com.example.whatsdam.model


//Aquesta classe es l'encarregada de emmagatzemar una llista de items o vistetes o d'allo que volem
//mostrar al recycler, també es on hem de dir el metode per afegir els objectes a la llista
// A xicoteta escala es on tractariem les dades, que bé podrien vindre duna BD o de internet etc

object Missatges {

    var missatges: ArrayList<Missatge> = ArrayList()

    //als apunts està aixi
/*
    var missatges: ArrayList<Missatge>

    init {
        missatges = ArrayList()
    }
*/
    fun add(nomUsuari :String, text:String){
        val missatge = Missatge(nomUsuari, text)
        missatges.add(missatge)
    }
}