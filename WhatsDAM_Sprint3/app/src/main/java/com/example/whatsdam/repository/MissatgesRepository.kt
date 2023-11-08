package com.example.whatsdam.repository

import com.example.whatsdam.model.Missatge
import com.example.whatsdam.model.Missatges


// Aquesta classe es léncarregada de fer de intermediaria entre el model i la vistaModel
class MissatgesRepository private constructor() {

    companion object {
        private var INSTANCE: MissatgesRepository? = null
        fun getInstance(): MissatgesRepository {
            if (INSTANCE == null) {
                INSTANCE = MissatgesRepository()
            }
            return INSTANCE!!
        }

    }

    fun getLlistaMissatges(): ArrayList<Missatge> {
        return Missatges.missatges
    }

    fun getTamanyLlistaMissatges(): Int {
        return Missatges.missatges.size
    }

    fun addMissatge(nomUsuari: String, text: String) {
        val missatge = Missatge(nomUsuari, text)
        Missatges.missatges.add(missatge)
    }

}