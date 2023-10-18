package com.example.whatsdam

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageButton
import android.widget.TextView
import com.example.whatsdam.databinding.ActivityMessagesWindowBinding//fixat amb el nom!! ha de ser com el nom de la classe Activity[nomclase]Binding
class MessagesWindow : AppCompatActivity() {
    private lateinit var binding: ActivityMessagesWindowBinding //fixat amb el nom!! ha de ser com el nom de la classe Activity[nomclase]Binding obri el import
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_messages_window)
        binding = ActivityMessagesWindowBinding.inflate(layoutInflater)
        setContentView(binding.root)// es pot posar així o com apareix al MainActivity.kt

        val nickname = intent.getStringExtra("nickName")
        val serverAdress = intent.getStringExtra("serverAddress")

        binding.connectionInfoTextView.text = ("Connectat a $serverAdress com a $nickname") //com podem observar no cal fer el toString perque es un textView

        var botoEnviar :ImageButton = binding.sendMessage //Hem creat una variable per a fer mes facil la lectura del codi

        botoEnviar.setOnClickListener{ //binding.sendMessage.setOnClickListener podriem haver-ho posat aixi, sense la variable de la linea de dalt
            binding.MessageText.text.clear()
        }
    }
}