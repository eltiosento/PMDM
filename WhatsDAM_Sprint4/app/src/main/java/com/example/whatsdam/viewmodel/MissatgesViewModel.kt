package com.example.whatsdam.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.whatsdam.model.Missatge
import com.example.whatsdam.repository.MissatgesRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext


class MissatgesViewModel : ViewModel() {

    // Adaptador encapsulat com a LiveData
    private val _adaptador = MutableLiveData<AdaptadorMissatges>().apply {
        value = AdaptadorMissatges()
    }
    val adaptador: MutableLiveData<AdaptadorMissatges> = _adaptador // Variable pública

    val repository = MissatgesRepository.getInstance()

    val llistaMissatges: LiveData<ArrayList<Missatge>> by lazy {
        repository.getLlistaMissatges()
    }

    // Última posició encapsulada com a LiveData, és a dir, volem un atribut que siga un número
    // que represente l'ultima posició, el que pasa es que volem que siga un LiveData de tipus Int,
    // sense instanciar, aixo ja ho farem al un mètode. Exemple en java---> private int edat;
    private val _ultimaPosInserida = MutableLiveData<Int>()
    val ultimaPosInserida: MutableLiveData<Int> = _ultimaPosInserida // Variable pública


    fun setAfegirMissatge(msg: Missatge) {
        viewModelScope.launch(Dispatchers.Main) {
            withContext(Dispatchers.IO) {
                repository.enviarMissatge(msg)
            }
        }
    }

    fun getUserName(): String {
        return repository.nomUsuari
    }

    // Obté el servidor des del repositori
    fun getServer(): String {
        return repository.server
    }

}