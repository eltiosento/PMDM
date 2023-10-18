package com.ieseljust.pmdm.comptador


import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    val TAG = "Estic passant per: "
    var comptador=0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "Al mètode onCreate")
        setContentView(R.layout.activity_main)

        // Referencia al TextView
        val textViewContador=findViewById<TextView>(R.id.textViewComptador)

        // Inicialitzem el TextView amb el comptador a 0
        textViewContador.setText(comptador.toString())

        // Referencia al botón d'increment
        val btAdd=findViewById<Button>(R.id.btAdd)

        // Referencia al botón de restar
        val btResta=findViewById<Button>(R.id.btResta)

        // Referencia al botón d'increment
        val btReset=findViewById<Button>(R.id.btReset)

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón +
        btAdd.setOnClickListener {
            comptador++
            textViewContador.setText(comptador.toString())
        }

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón -
        btResta.setOnClickListener {
            if (comptador == 0){
                comptador = 0
            }else{
                comptador--
                textViewContador.setText(comptador.toString())
            }
        }

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón reset
        btReset.setOnClickListener {
            comptador=0
            textViewContador.setText(comptador.toString())
        }

    }
    // Guardem els valors amb el mètode onSaveInstanceState creant un objecte estat de la Clase Bundle
    override fun onSaveInstanceState(estat: Bundle) {
        super.onSaveInstanceState(estat)

        // Posem al objecte estat el valor de comptador donant-li una clau,id o nom contador
        estat.putInt("contador", comptador)
    }

    //Amb el mètode onRestoreInstanceState li passem un objecte Bundle
    override fun onRestoreInstanceState(estat: Bundle) {
        super.onRestoreInstanceState(estat)

        //asignem a la variable comptador el valor que em guardat amb onSaveInstanceState diguenli la clau
        comptador = estat.getInt("contador")
        //actualitzem el textView
        val textViewContador = findViewById<TextView>(R.id.textViewComptador)
        textViewContador.text = comptador.toString() // ho psem aixi perque es com ho recomana AStudio

    }

}



