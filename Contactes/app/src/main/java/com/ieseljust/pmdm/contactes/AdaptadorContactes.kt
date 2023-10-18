package com.ieseljust.pmdm.contactes

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView

//Android studio al posar aquesta sintaxi, ens donara un error. Polsem la bombilla
//I ens dira de implementar members


//Aquesta clase es la que sencarrega d'agafar la informacio que tenim "contactes" i posarla al recycler view
class AdaptadorContactes(val context: Context,
val eventListener: (Contacte, View) -> Boolean): RecyclerView.Adapter<RecyclerView.ViewHolder>()
{

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        // S'invoca quan es crea un nou viewholder
        val inflater = LayoutInflater.from(parent.context)
        val vista = inflater.inflate(R.layout.contacte_layout, parent, false);
        return ContacteViewHolder(vista, context)

    }

    override fun getItemCount(): Int {
        return Contactes.contactes.size
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        (holder as ContacteViewHolder).bind(Contactes.contactes[position], eventListener);
    }
}
