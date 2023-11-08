package com.example.whatsdam.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.whatsdam.repository.MissatgesRepository


class MissatgesViewModel : ViewModel() {

    // Adaptador encapsulat com a LiveData
    private val _adaptador = MutableLiveData<AdaptadorMissatges>().apply {
        value = AdaptadorMissatges()
    }
    val adaptador: MutableLiveData<AdaptadorMissatges> = _adaptador // Variable pública

    // Última posició encapsulada com a LiveData, és a dir, volem un atribut que siga un número
    // que represente l'ultima posició, el que pasa es que volem que siga un LiveData de tipus Int,
    // sense instanciar, aixo ja ho farem al un mètode. Exemple en java---> private int edat;
    private val _ultimaPosInserida = MutableLiveData<Int>()
    val ultimaPosInserida: MutableLiveData<Int> = _ultimaPosInserida // Variable pública

    // Mètode per afegir missatges y actualitzar els LiveData (els atibuts del ViewModel)
    // Vamos, un setter de java, peró vamos un multisetter perquè fa varies coses a l'hora...
    // Aquest mètode és qui s'encarrega de tractar els atributs
    fun setAfegirMissatge(nomUsuari: String, text: String) {

        //Afig el missatje, però ¡¡¡OJO!!!! AL REPOSITORI
        MissatgesRepository.getInstance().addMissatge(nomUsuari, text)

        //Actualitza l'última posició insertada, ARA!! li donem valor a ultimaPosInserida
        _ultimaPosInserida.value = MissatgesRepository.getInstance().getTamanyLlistaMissatges() -1

        // NOTIFIQUEM AL ADAPTADOR ASI!!!! No a MessagesWindow com vam fer abans de l'estructura MVVM(com estem fent ara)
        // Que hem insertat un missatge nou i el adaptador ja fa el que ha de fer, per al RecycleView, etc etc
        _adaptador.value?.notifyItemInserted(MissatgesRepository.getInstance().getTamanyLlistaMissatges() - 1)
    }

}