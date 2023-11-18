package com.example.whatsdam.model

import androidx.lifecycle.MutableLiveData
import org.json.JSONObject


//Aquesta classe es l'encarregada de emmagatzemar una llista de items o vistetes o d'allo que volem
//mostrar al recycler, també es on hem de dir el metode per afegir els objectes a la llista
// A xicoteta escala es on tractariem les dades, que bé podrien vindre duna BD o de internet etc

object Missatges {

    private var _missatges = MutableLiveData<ArrayList<Missatge>>().apply {
        value = ArrayList<Missatge>()
    }
    val missatges: MutableLiveData<ArrayList<Missatge>> = _missatges


    fun getMissatgeAt(posicio: Int): Missatge {
        return _missatges.value!![posicio]
    }


    fun add(nomUsuari: String, text: String) {
        val missatge = Missatge(nomUsuari, text)
        _missatges.value?.add(missatge)
    }

    suspend fun enviarMissatge(missatge: Missatge){
        val jsonMissatge = JSONObject().apply {
            put("command","register")
            put("user",missatge.nomUsuari)
            put("content", missatge.contingutMissatge)
        }.toString()
        CommunicationManager.sendServer(jsonMissatge)
    }
}