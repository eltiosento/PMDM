package com.example.whatsdam.viewmodel

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.whatsdam.R
import com.example.whatsdam.repository.MissatgesRepository


// Part 2.2, Al adaptador fem que herete de recycler.Adapter i li pasem el viewholder nostre
//Este bon xic es l'encarregat d'enllaçar les vistes ViewHolder al RecycleView, es qui fa d'adaptador
//Recorda fer el imlementar members que ho kotlin amb la bombilleta
class AdaptadorMissatges() : RecyclerView.Adapter<MissatgeViewHolder>() {

    //Este tio va a tornar-li al nostre Viewholder el layout on tenim les vistetes -->my_msg_viewholder.xml
    //L'estructura mos la creguem... lo del parent i el viewType---no fem cas
    //Creem l´objecte inflater que ve del LayoutInflater proporcionat pel ViewGroup pa
    //poder enllaçar una vista que android fa a la nostra
    //ara amb la variable vista ja podem utilitzar el inflater per a crear la nostra vista que li la pasem com a parametre R.layout.my_msg_viewholder
    //finalment com hem dit este metode retorna el nostreViewHolder al que li hem pasat una vista, la del xml
    //En resum agafa el layout de la visteta, li la pasa al ViewHolder i ja la tenim preparada pa poder gastarla al main, mos la fa palpable
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MissatgeViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val vista = inflater.inflate(R.layout.my_msg_viewholder, parent, false)
        return MissatgeViewHolder(vista)

    }

    // molt facil, que ens retorne el tamany de la llista que tenim Al Repositori (MVVM)
    override fun getItemCount(): Int {
        return MissatgesRepository.getInstance().getTamanyLlistaMissatges()
    }

    //Este tio va a recorrer la llista de missatges i cridar al mètode bind del nostre ViewHolder
    //Com que kotlin ja ens ha creat el holder i la position, és molt fàcil,
    //creem un item que serà igual a cada missatge de la llista de missatges. (Aquesta llista la recuperem del REPOSITORI (MVVM)
    //despres cridem al holder(objecte del nostre ViewHolder, cridem al metode que hem creat, el .bind
    //i li passem el item per a que el pinte.
    //Basicament es com fer un for de la llista for(int i = 0;i < llista.size();i++) i-->position
    //Per lo tant item es igual a llista[i]
    override fun onBindViewHolder(holder: MissatgeViewHolder, position: Int) {
        val item = MissatgesRepository.getInstance().getLlistaMissatges()[position]
        holder.bind(item)

    }
}