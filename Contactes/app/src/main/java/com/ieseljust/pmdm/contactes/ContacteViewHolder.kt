package com.ieseljust.pmdm.contactes

import android.content.Context
import android.util.Log
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView

//a aquesta classe li diguem que es una subclasse de RecyclerView.ViewHolder amb class ContacteViewHolder : RecyclerView.ViewHolder
// ens importara el paquet de androix. recycleview.......
//com es queixarà li polsem la bombilleta i li diguem que ens afegixca el viewholder del seu constructor i també ens fara un import

// Es l'encarrega de pintar les vistetes al recycler
class ContacteViewHolder(itemView: View, context: Context) : View.OnClickListener, RecyclerView.ViewHolder(itemView) {
    val img =
        itemView.findViewById(R.id.imageView) as ImageView //hem de importar els paquets i amb as ImageView estem diguent-li de quin tipus "classe"son
    val name =
        itemView.findViewById(R.id.nomContacte) as TextView //hem de importar els paquets i amb as TextView estem diguent-li de quin tipus "classe" son

    // Enllacem les dades del contacte amb la vistaHolder es a dir estic enllaçant un contacte amb el que seria la visteta que va dins del Recicler
    fun bind(contacte: Contacte, eventListener:(Contacte, View) -> Boolean) {

        name.text = contacte.name
        img.setImageResource(contacte.img)

        // Gestionem d'aci el click llarg
        itemView.setOnLongClickListener {
            eventListener(contacte, itemView)
        }
        
    }

    init {
        itemView.setOnClickListener(this)
    }

    override fun onClick(item: View?) {
        // Codi per mostrar la notificacio
        // ...
        // De moment la mostrem al Log
        Log.d("Metode onClick", "Has fet click sobre ${name.text}")
    }

    val toast =
        Toast.makeText(context, "Has fet click sobre ${name.text}", Toast.LENGTH_SHORT).show()

}