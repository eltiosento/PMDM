package com.example.whatsdam.viewmodel

import android.util.Log
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.whatsdam.R
import com.example.whatsdam.repository.MissatgesRepository


// Part 2.2, Al adaptador fem que herete de recycler.Adapter i li pasem el viewholder nostre
//Este bon xic es l'encarregat d'enllaçar les vistes ViewHolder al RecycleView, es qui fa d'adaptador
//Recorda fer el imlementar members que ho kotlin amb la bombilleta
class AdaptadorMissatges() : RecyclerView.Adapter<RecyclerView.ViewHolder>() {

    private val MISSATGE_D_USUARI = 1
    private val MISSATGE_D_ALTRE = 2

    val repository = MissatgesRepository.getInstance()
    override fun getItemViewType(position: Int): Int {
        // Aquesta funcio permet definir el tipus de vista segons algun criteri

        // Obtenim el missatge en la posició que se'ns indica
        var missatge = repository.getMissatges(position)

        // Comprovem si l'usuari que ha enviat el missatge
        // és l'usuari actual (per això fem ús del nom d'usuari
        // guardat al repositori)
        return if (missatge.nomUsuari == repository.nomUsuari) {
            MISSATGE_D_USUARI
        } else {
            MISSATGE_D_ALTRE
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        //Log.d("DEbug [misatgesadapter]")
        val inflater = LayoutInflater.from(parent.context)
        //val vista = inflater.inflate(R.layout.my_msg_viewholder,parent,false)

        return when (viewType) {
            MISSATGE_D_USUARI -> {
                val vista = inflater.inflate(R.layout.my_msg_viewholder, parent, false)
                MissatgeViewHolder(vista)
            }

            MISSATGE_D_ALTRE -> {
                val vista = inflater.inflate(R.layout.other_msg_viewholder, parent, false)
                MissatgeAltreViewHolder(vista)
            }

            else -> throw IllegalArgumentException("Vista desconeguda")
        }


    }

    // molt facil, que ens retorne el tamany de la llista que tenim Al Repositori (MVVM)
    override fun getItemCount(): Int {
        return repository.getNumMissatges()
    }

    //Este tio va a recorrer la llista de missatges i cridar al mètode bind del nostre ViewHolder
    //Com que kotlin ja ens ha creat el holder i la position, és molt fàcil,
    //creem un item que serà igual a cada missatge de la llista de missatges. (Aquesta llista la recuperem del REPOSITORI (MVVM)
    //despres cridem al holder(objecte del nostre ViewHolder, cridem al metode que hem creat, el .bind
    //i li passem el item per a que el pinte.
    //Basicament es com fer un for de la llista for(int i = 0;i < llista.size();i++) i-->position
    //Per lo tant item es igual a llista[i]
    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {

        if (getItemViewType(position) === MISSATGE_D_USUARI) {
            (holder as MissatgeViewHolder).bind(repository.getMissatges(position))

        } else {
            (holder as MissatgeAltreViewHolder).bind(repository.getMissatges(position));
        }

    }


}