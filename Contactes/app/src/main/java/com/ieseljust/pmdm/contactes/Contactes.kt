package com.ieseljust.pmdm.contactes

object Contactes {
    // Dataset per al Recyclerview: Llista de contactes, inicialment buida
    var contactes: ArrayList<Contacte> //  en java seria ArrayList<Contacte> contactes;

    // Definim una llista que contindra els contactes a  afegir al Dataset.
    private var fontContactes: ArrayList<Contacte>

    init {
        //  Inicialització de la llista de contactes
        contactes = ArrayList<Contacte>() // en java seria contactes = new ArrayList;

        // I creem la llista amb els contactes per afegir
        fontContactes = ArrayList<Contacte>(
            listOf(
                Contacte("Ahsoka Tano", R.drawable.ahsoka),
                Contacte("Baylan Skoll", R.drawable.baylan),
                Contacte("Ezra Bridger", R.drawable.ezra),
                Contacte("Hera Syndulla", R.drawable.hera),
                Contacte("Morgan Elsbert", R.drawable.morgan),
                Contacte("Sabine Wren", R.drawable.sabine),
                Contacte("Shin Hati", R.drawable.shin),
                Contacte("Gran Almirante Thrawn", R.drawable.thrawn),
                Contacte("Zeb Orrellios", R.drawable.zeb)
            )
        )
    }

    // Mètode per afegir un contacte
    fun add(): Boolean {
        // Comprovem abans que res que queden contactes per poder afegir
        if (fontContactes.size > 0) {
            // Afegim a la llista de contactes el primer element
            // de la llista que fa de font de contactes
            contactes.add(fontContactes[0])
            // I l'eliminem de la font
            fontContactes.removeAt(0)
            // Retornem true per indicar que s'ha afegit el contacte
            return true
        }
        return false

    }

    // Mètode per eliminar un contacte:
    fun remove(contacteAEliminar: Contacte): Int {
        // Busquem el contacte en el Dataset
        val index = contactes.indexOf(contacteAEliminar)
        // L'eliminem
        contactes.remove(contacteAEliminar)
        // I el reincorporem de nou a la font
        fontContactes.add(contacteAEliminar)
        // Finalment, retornem l'índex del contacte eliminat
        return index
    }

}