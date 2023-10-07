package com.ieseljust.pmdm.comptador


import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.ieseljust.pmdm.comptador.databinding.ActivityMainBinding //Importar la classe de vinculació per al Binding

class MainActivity : AppCompatActivity() {
    //val TAG = "Estic passant per: "

    private lateinit var binding: ActivityMainBinding //Declarar l’objecte (binding) que accedirà a aquesta classe

    var comptador=0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding= ActivityMainBinding.inflate(layoutInflater) //Definim a binding amb l'unflat de la vista
        val view = binding.root
        //Log.d(TAG, "Al mètode onCreate")
        setContentView(view) //Modificar el SetContentView per afegir-lo l’arrel del binding (binding.root)
                            // setContentView es el que feia findViewById<TextView>(R.id.textViewComptador)
/*
        // Referencia al TextView
        val textViewContador=findViewById<TextView>(R.id.textViewComptador)

        // Inicialitzem el TextView amb el comptador a 0
        textViewContador.setText(comptador.toString())

        // Referencia al botón d'increment
        val btAdd=findViewById<Button>(R.id.btAdd)

        // Referencia al botón de restar
        val btResta=findViewById<Button>(R.id.btResta)

        // Referencia al botón de reset
        val btReset=findViewById<Button>(R.id.btReset)

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón +

 */

        // Declarem variables
        val textViewContador = binding.textViewComptador
        val btAdd = binding.btAdd
        val btResta = binding.btResta
        val btReset = binding.btReset


        btAdd.setOnClickListener {
            comptador++
            binding.textViewComptador.setText(comptador.toString())

            //textViewContador.setText(comptador.toString())
        }

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón -
        btResta.setOnClickListener {
            if (comptador == 0){
                comptador = 0
            }else{
                comptador--
                binding.textViewComptador.setText(comptador.toString())

                //textViewContador.setText(comptador.toString())
            }
        }

        // Asociaciamos una expresióin lambda como
        // respuesta (callback) al evento Clic sobre
        // el botón reset
        btReset.setOnClickListener {
            comptador=0
            binding.textViewComptador.setText(comptador.toString())

            //textViewContador.setText(comptador.toString())
        }

    }
    // Guardem els valors amb el mètode onSaveInstanceState creant un objecte estat de la Clase Bundle
    override fun onSaveInstanceState(estat: Bundle) {
        super.onSaveInstanceState(estat)

        // Posem al objecte estat el valor de comptador donanle una clau,id o nom contador
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
                                                    // al clicar la bombilleta
    }

}



