package com.example.whatsdam

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView


// Part 2.2, el adaptador, li donem un nom i li pasem la llista que volem que volem fer apareixer al Recycler
// També fem que herete de recycler.Adapter i li pasem el viewholder nostre
//Este bon xic es l'encarregat d'enllaçar les vistes ViewHolder al RecycleView, es qui fa d'adaptador
//Recorda fer el imlementar members que ho kotlin amb la bombilleta
class AdaptadorMissatges(private val missatges: ArrayList<Missatge>) :
    RecyclerView.Adapter<MissatgeViewHolder>() {

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

    // molt facil, que ens retorne el tamany de la llista que tenim
    override fun getItemCount(): Int {
        return missatges.size
    }

    //Este tio va a recorrer la llista de missatges i cridar al mètode bind del nostre ViewHolder
    //Com que kotlin ja ens ha creat el holder i la posició, es molt facil
    //creem un item que serà cada missatge i li asignem una posicio
    //despres cridem al holder(objecte del nostre ViewHolder, cridem al metode que hem creat, el .bind
    //i li passem el item.
    //Basicament es com fer un for de la llista per a iterar i despres pintar amb el bind
    override fun onBindViewHolder(holder: MissatgeViewHolder, position: Int) {
        val item = missatges[position]
        holder.bind(item)

    }
}