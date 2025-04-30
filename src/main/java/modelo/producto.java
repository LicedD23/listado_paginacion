/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package modelo;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author SENA
 */
public class producto {
    private int id;
    private String nombre;
    private double precio;
    private String categoria;
    
    public static List<Producto> generarProductos(int cantidad){
        List<Producto> productos = new ArrayList<>();
        String[] categorias = {"Electrónica", "Ropa", "Hogar", "Alimentos", "Juguetes"};
        
        for(int i = 1; i <= cantidad; i++){
            Producto p = new Producto ();
            p.setId(i);
            p.setNombre("Producto " + i);
            p.setPrecio(10 + Math.random() + 90);
            p.setCategoria(categorias[i % categorias.length]);
            productos.add(p);
        }
        return productos;
    }
}