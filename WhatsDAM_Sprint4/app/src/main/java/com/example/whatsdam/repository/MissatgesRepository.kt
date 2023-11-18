package com.example.whatsdam.repository

import androidx.lifecycle.MutableLiveData
import com.example.whatsdam.model.CommunicationManager
import com.example.whatsdam.model.Missatge
import com.example.whatsdam.model.Missatges
import org.json.JSONObject


// Aquesta classe es léncarregada de fer de intermediaria entre el model i la vistaModel
class MissatgesRepository private constructor(){


    companion object {
        private var INSTANCE: MissatgesRepository? = null
        fun getInstance(): MissatgesRepository {
            if (INSTANCE == null) {
                INSTANCE = MissatgesRepository()
            }
            return INSTANCE!!
        }

    }
    var nomUsuari: String = ""
    var server: String = ""



    fun getMissatges(posicio:Int): Missatge{
        return Missatges.getMissatgeAt(posicio)
    }


    fun getNumMissatges(): Int {
        return Missatges.missatges.value!!.size
    }


    suspend fun Login(nomUsuari: String, server: String): JSONObject {
        this.nomUsuari = nomUsuari
        this.server = server
        return CommunicationManager.Login(nomUsuari, server)
    }

    suspend fun enviarMissatge(msg: Missatge) {
        Missatges.enviarMissatge(msg)
    }


    fun getLlistaMissatges(): MutableLiveData<ArrayList<Missatge>> {
        return Missatges.missatges
    }

}