package com.example.whatsdam.viewmodel

import android.icu.text.SimpleDateFormat
import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.whatsdam.R
import com.example.whatsdam.model.Missatge
import java.util.Date

//punt 2 Entrem al lio, Esta calsse es l'encarregada de pintar les dades que volem al Recycler
// per tant li hem de dir que volem, en aquest cas volem el text i l'hora, doncs o referenciem
class MissatgeViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    val text =
        itemView.findViewById(R.id.msg_text) as TextView //Podem instanciar aquestes variables de 3 formes o be amb el "as" al final
    val hora: TextView =
        itemView.findViewById(R.id.msg_me_timestamp) // O bé al principi dient-li de quin tipus son
    // O bé d'aquesta forma      val texto = itemView.findViewById<TextView>(R.id.msg_text)

    // 1. Creem un objecte per al format de l'hora ja que aquesta la volem del sistema i no forma part del text
    val dateFormat = SimpleDateFormat("HH:mm")


    //Amb el bind actualitzem les dades, es a dir LI POSEM CONTINGUT per a pintar
    // Dalt sols creaem i amb el bind rellenem---> amb el .text( el .setText de java)
    // si fora una imatge ---> text.setImageResource(missatge.img) text--> val text    missatge --> objecte    .img --> aribut de missatge
    fun bind(missatge_text: Missatge) {
        text.text = missatge_text.contingutMissatge
        // 2. Obtenim l'hora amb la funció `Date()`
        val horaActual = Date()

        // 3. Obtenim l'hora en el format que hem creat:
        val horaFormatada = dateFormat.format(horaActual)
        hora.text = horaFormatada
    }


}