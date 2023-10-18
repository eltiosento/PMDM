package com.example.whatsdam

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import com.example.whatsdam.databinding.ActivityMainBinding //binding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding //binding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        //binding
        setContentView(R.layout.activity_main)
        binding = ActivityMainBinding.inflate(layoutInflater)//inflate fa d'enllaç amb les vistes del xml
        val view = binding.root
        setContentView(view)


        //Quan apretem el botó
        binding.buttonConnect.setOnClickListener{

            // varaibles que arrepleguen quan introduim, el nikname i l'adressa per teclat del movil

            //Apunt important: com que el nickNameText i el serverAddressText son EditText, per accedir al text gastem el .text, però amés ens fa falta el .toString
            //Perque es un Editable no un String a diferencia dels textView que amb .text ja ens torna un String
            //Una altra curiositat esque els EditText no tenen perdua d'estat
            val nickName = binding.nickNameText.text.toString()
            val serverAddress = binding.serverAddressText.text.toString()

            // Condició per a que pugam donar pas al intent i obrir la nova activitat
            if (validarNikname(nickName) && validarServerAddress(serverAddress)){

                //Per tant, si tenim un nom i una ip valida aleshores creem l'objecte intent que es qui sap obrir una nova activiatat
                //context obté recursos nesseçaris per a fer que l'intent vaja
                //despres li em de passar la nova activiatat amb els ::class.java
                val intent = Intent(baseContext, MessagesWindow::class.java)

                //Al intent li hem de passar unes dades que despres a l'altra activitat hem de invocar per tant ho fem aixi
                // amb el imput extra i donant  una clau, valor
                intent.putExtra("nickName",nickName)
                intent.putExtra("serverAddress",serverAddress)
                //Arranquem la segona activitat
                startActivity(intent)

            }

        }

    }

    //Funcioneta per a comprobar que la cadena que ens passen esta plena
    private fun validarNikname(nikeName: String): Boolean{
        return nikeName.isNotEmpty()
    }

    //Funcioneta per a comprobar que la ip que s'introdueix es del format adecuat
    private fun validarServerAddress(serverAddress:String):Boolean{
        val ipRegex = """^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$""".toRegex()
        return ipRegex.matches(serverAddress)
    }


}