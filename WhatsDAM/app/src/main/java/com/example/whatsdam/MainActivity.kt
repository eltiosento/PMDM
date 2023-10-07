package com.example.whatsdam

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val editTextNikname=findViewById<EditText>(R.id.nickNameText)
        val editTextserverAddress=findViewById<EditText>(R.id.serverAddressText)
        val buttonConnect=findViewById<Button>(R.id.buttonConnect)
        buttonConnect.setOnClickListener{

        }



    }
}