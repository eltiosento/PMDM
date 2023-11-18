package com.example.whatsdam.viewmodel

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.example.whatsdam.repository.MissatgesRepository

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import java.lang.Exception

class LoginViewModel(application: Application) :
    AndroidViewModel(application) {

    // Definim l'estat del login com a LiveData
    val _loginStatus = MutableLiveData<JSONObject>().apply {
        value = JSONObject()
    }
    val loginStatus: MutableLiveData<JSONObject> = _loginStatus


    fun Login(username: String, server: String) {
        // Com que el metode Login del model i el repositori
        // son funcions de suspensio, hem d'invocar-los en
        // en un bloc de corrutina.
        Log.d("Debug [LoginViewModel]", "En Login")
        viewModelScope.launch(Dispatchers.Main) {
            Log.d("Debug [LoginViewModel]", "En Launching..")
            // Tasques que s'executen en el fil principal
            val resultat = withContext(Dispatchers.IO) {
                Log.d("Debug [LoginViewModel]", "En Dispatchers..")
                // Tasques depenen de l'entrada i l0eixida
                var resposta = MissatgesRepository.getInstance().Login(username, server)
                Log.d("Debug [LoginViewModel]", "REP: " + resposta.toString())

                // No podem assignar directamen el valor,
                // sino que hem d'utilitzar postValue
                _loginStatus.postValue(resposta)


            }

        }

    }


}