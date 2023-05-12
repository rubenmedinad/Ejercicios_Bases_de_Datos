package com.softtek.presentacion;

import com.softtek.modelo.campos;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {
        campos c = new campos(); // Creamos una instancia de la clase Campos
        System.out.println(c.muestra()); // Imprime el valor actual de x (0)
        c.incrementa();
        c.incrementa();
        c.incrementa();// Incrementa el valor de x en 1
        System.out.println(c.muestra()); // Imprime el nuevo valor de x (1)
    }
}

