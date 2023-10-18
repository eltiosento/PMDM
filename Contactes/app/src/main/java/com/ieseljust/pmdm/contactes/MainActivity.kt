package com.ieseljust.pmdm.contactes

import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.ieseljust.pmdm.contactes.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    // Creem un objecte binding amb la classe de vinculacio
    private lateinit var binding: ActivityMainBinding
    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        binding = ActivityMainBinding.inflate(layoutInflater)

        // Establim el contingut de la vista
        val view = binding.root
        setContentView(view)

        // Establim un Layout Manager per al RecyclerView, en aquest cas LinearLayoutManager que va scroll vertical
        binding.ContactesRecyclerView.layoutManager = LinearLayoutManager(this)
        // Indiquem que les targetes son de grandaria fixa
        binding.ContactesRecyclerView.setHasFixedSize(true)
        // Afegim l'adaptador de contactes
        binding.ContactesRecyclerView.adapter =
            AdaptadorContactes(this, { contacte: Contacte, v: View -> itemLongCliked(contacte, v) })

        // Associem un escoltador d'esdeveniments al clic sobre
        // el boto d'accio flotant per afegir un element nou a la llista
        binding.fabAdd.setOnClickListener {
            if (Contactes.add()) { //si aquest metode retorna true(mirar ci¡om sa fet a la seua clase)
                // Si el contacte s'ha afegit, ho notifiquem a l'adaptador
                // per a que el RecyclerView el dibuixe
                binding.ContactesRecyclerView.adapter?.notifyItemInserted(Contactes.contactes.size - 1) //que es pose com a ultim element
            }
        }

    }

    private fun itemLongCliked(contacte: Contacte, v: View): Boolean {
        Toast.makeText(applicationContext, "Click llarg sobre" + contacte.name, Toast.LENGTH_SHORT)
            .show()

        // Eliminem el contacte amb el mètode remove i
        // obtenim la posició que ocupava al DataSet
        var index = Contactes.remove(contacte)

        // Informem l'adaptador del RecyclerView que s'ha
        // eliminat un element in la posició index.
        binding.ContactesRecyclerView.adapter?.notifyItemRemoved(index)
        return true
    }
}