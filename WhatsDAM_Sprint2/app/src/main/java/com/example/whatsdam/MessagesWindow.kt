package com.example.whatsdam

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageButton
import android.widget.LinearLayout
import android.widget.TextView
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.whatsdam.databinding.ActivityMessagesWindowBinding//fixat amb el nom!! ha de ser com el nom de la classe Activity[nomclase]Binding

class MessagesWindow : AppCompatActivity() {
    private lateinit var binding: ActivityMessagesWindowBinding //fixat amb el nom!! ha de ser com el nom de la classe Activity[nomclase]Binding obri el import
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_messages_window)
        binding = ActivityMessagesWindowBinding.inflate(layoutInflater)
        setContentView(binding.root)// es pot posar així o com apareix al MainActivity.kt
        iniciarRecyclerView()

        //Arreplem dades del intent del MainActivity, de la Activitat on fem el login
        val nickname = intent.getStringExtra("nickName")
        val serverAdress = intent.getStringExtra("serverAddress")
        //Li posem a la visteta on ix el nikname i la ip
        binding.connectionInfoTextView.text =
            ("Connectat a $serverAdress com a $nickname") //com podem observar no cal fer el toString perque es un textView

        //Per a fer que el botó buide el contingut
        var botoEnviar: ImageButton =
            binding.sendMessage //Hem creat una variable per a fer mes facil la lectura del codi

        botoEnviar.setOnClickListener { //binding.sendMessage.setOnClickListener podriem haver-ho posat aixi, sense la variable de la linea de dalt
            if (binding.MessageText.text.isNotEmpty()) {
                //Estem fent que per cada clik al botó agfegim el text introduit amb el metode que tenim
                //a la classe Missatges add, que demana el nickname i el text que posem
                Missatges.add(nickname.toString(), binding.MessageText.text.toString())

                //Notifiquem que sa modificat un element es a dir sa modificat la llista de missatges
                //Aço el que fa es que estem dient al recicler, A LA VISTA RECYCLE la del xml, que hi han canvis
                // i que aquest canvis son a l'ultima posició de llista
                //per tant quan polsem el botó farà l'acció de introduir per pantalla
                //l'ultim missatge
                //recorda que al adaptador li hem passat la llista i pertant com que cada volta que polsem
                //el botó, aquesta es modifica, li ho diguem amb aquest codi
                binding.MessagesRecycleView.adapter?.notifyItemInserted(Missatges.missatges.size - 1)

                //Amb aquest instrucció dem un auto scroll a l'ultim missatge
                binding.MessagesRecycleView.smoothScrollToPosition(Missatges.missatges.size - 1)

                binding.MessageText.text.clear()  //aquesta linea seria per a buidar el text introduit
            }

        }

    }

    //COMENCEM AMB EL RECYCLERVIEW

    fun iniciarRecyclerView() {
        // posem en una variable el RecyclerView del xml, on l'hem creat amb binding.id del recycler
        val recyclerView = binding.MessagesRecycleView
        //ara li fem un layoutManager --> este manager es per a que poguem fer un scroll vertical
        recyclerView.layoutManager = LinearLayoutManager(this)
        //are li diguem que tinga una grandaria fixa
        recyclerView.setHasFixedSize(true)
        //ara li cridem al ADAPTADOR i li assignem el nostre adaptadorMissatges
        //i també li pasem la llista de mensatges, ja que l'hem construit aixi
        //Així doncs li pasem l'objecte(clase) Missatges.la llista
        recyclerView.adapter = AdaptadorMissatges(Missatges.missatges)
    }
}