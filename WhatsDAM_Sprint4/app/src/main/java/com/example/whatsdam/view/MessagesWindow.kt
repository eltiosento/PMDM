package com.example.whatsdam.view

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.whatsdam.R
import com.example.whatsdam.databinding.ActivityMessagesWindowBinding//fixat amb el nom!! ha de ser com el nom de la classe Activity[nomclase]Binding
import com.example.whatsdam.model.Missatge
import com.example.whatsdam.viewmodel.MissatgesViewModel

class MessagesWindow : AppCompatActivity() {


    private lateinit var binding: ActivityMessagesWindowBinding //fixat amb el nom!! ha de ser com el nom de la classe Activity[nomclase]Binding obri el import
    private lateinit var viewModel: MissatgesViewModel


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_messages_window)

        //Inicialitzem el binding
        binding = ActivityMessagesWindowBinding.inflate(layoutInflater)
        setContentView(binding.root)// es pot posar així o com apareix al MainActivity.kt

        // Inicialitzem el ViewModel
        viewModel = ViewModelProvider(this).get(MissatgesViewModel::class.java)

        // Observem el adaptador desde el objecte viwModel, i com tot objecte te atributs i mètodes que els cridem amb el "."
        // cridem al atribut adaptador i diguem a l'activitat(MessagesWindow) que l'OBSERVE,es a dir,
        // suscrivim l'activitat al adaptador através de ViewModel, per tant,
        // quan passa un event, viatja desde l'activitat(View) pel ViewModel fins al Model, aquest canvia(s'insereix un missatge)
        // i per tant el viewModel també, aleshores com la vista està suscrita al ViewModel,
        // fem que s'actualitze el adaptador (encarregat de tractar el Recycler amb it-> LiveData AdaptadorMissatges
        viewModel.adaptador.observe(this) {
            binding.MessagesRecycleView.adapter = it
        }
        // Observem l'última posició inserida desde el ViewModel, aleshores,
        //D'igualmenera, l'activitat rep una notificacio quan canvia l'ultima posició,
        // Pertant ara el que volem es fer un smoot.... i li passem it -> LiveData Int
        // NOTA tant en la ultimaPosInserida com l'adaptador, SON MODIFICATS AL CRIDAR AL MÈTODE
        // DEL MISSATGESVIEWMODEL setAfegirMisatge, és aleshores quan tot canvia i el mateix ViewModel
        // envia les notificacions a la vista I AQUESTA AUTOMATICAMENT JA CANVIA!! màgia feta :)
        viewModel.ultimaPosInserida.observe(this) {
            binding.MessagesRecycleView.smoothScrollToPosition(it)
        }

        //Arreplem dades del intent del MainActivity, de la Activitat on fem el login
        val nickname = intent.getStringExtra("nickName")
        val serverAdress = intent.getStringExtra("serverAddress")
        //Li posem a la visteta on ix el nikname i la ip
        binding.connectionInfoTextView.text =
            ("Connectat a $serverAdress com a $nickname") //com podem observar no cal fer el toString perque es un textView

        iniciarRecyclerView()

        //EVENT D'APRETAR EL BOTÓ
        binding.sendMessage.setOnClickListener {
            val messageText = binding.MessageText.text.toString()
            if (messageText.isNotEmpty()) {
                val message = Missatge(nickname.toString(), messageText)
                //ES ARA quan cridem al mètode de MissatgesViewModel i aquest fa que les dades canvien
                // com que l'activitat esta suscrita al viewmodel, aquesta rep la notificació i ja fa el que li hem dit
                // als observadors, notificar al adaptador i fer el scroll amb l'ultima posició
                viewModel.setAfegirMissatge(message)
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
        //(MVVM)
        // ARA JA NO ES NECESSARI cridar al adaptador ací ja que l'observem desde el ViewModel
    }

}