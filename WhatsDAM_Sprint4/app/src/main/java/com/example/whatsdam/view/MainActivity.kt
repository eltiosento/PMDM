package com.example.whatsdam.view

import android.content.Intent
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.whatsdam.R
import com.example.whatsdam.databinding.ActivityMainBinding //binding
import com.example.whatsdam.viewmodel.LoginViewModel

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding //binding
    private lateinit var loginViewModel: LoginViewModel

    @RequiresApi(Build.VERSION_CODES.Q)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        loginViewModel = ViewModelProvider(this).get(LoginViewModel::class.java)

        //binding
        setContentView(R.layout.activity_main)
        binding =
            ActivityMainBinding.inflate(layoutInflater)//inflate fa d'enllaç amb les vistes del xml
        val view = binding.root
        setContentView(view)


        loginViewModel.loginStatus.observe(this) {
            Log.d("Debug [MainActivity]", it.toString())
            //try {
            if (it.has("status"))
                when (it.getString("status")) {
                    "error" -> {
                        if (it.has("message")) {
                            var msg = it.getString("message")
                            if (msg == "null") msg = "Servidor desconnectat.."

                        }
                        else{
                            "Servidor desconnectat.."
                        }
                        //}catch(e:Exception){
                        //   e.printStackTrace()
                        //}

                        binding.buttonConnect.visibility = View.VISIBLE

                    }

                    else -> {
                        Log.d("Debug [MainWindow]", this.toString())
                        // Si retorna status: ok, llancem l'intent
                        val intent = Intent(baseContext, MessagesWindow::class.java)

                        // Afegim les dades a l'Intent. Compte amb el .toString()
                        intent.putExtra("nickName", binding.nickNameText.text.toString())
                        intent.putExtra("serverAddress", binding.serverAddressText.text.toString())

                        // Quan es faça el login es guardara esta informacio en el model

                        startActivity(intent)

                    }
                }
        }

        //Quan apretem el botó
        binding.buttonConnect.setOnClickListener {
            val nickName = binding.nickNameText.text.toString()
            val serverAddress = binding.serverAddressText.text.toString()


            if (validarNikname(nickName) && validarServerAddress(serverAddress)) {
                binding.buttonConnect.visibility = View.GONE
                loginViewModel.Login(nickName, serverAddress)
            } else {
             Toast.makeText(this, "Dades incorrectes", Toast.LENGTH_SHORT).show()
            }
        }


    }

    //Funcioneta per a comprobar que la cadena que ens passen esta plena
    private fun validarNikname(nikeName: String): Boolean {
        return nikeName.isNotEmpty()
    }

    //Funcioneta per a comprobar que la ip que s'introdueix es del format adecuat
    private fun validarServerAddress(serverAddress: String): Boolean {
        val ipRegex = """^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$""".toRegex()
        return ipRegex.matches(serverAddress)
    }


}