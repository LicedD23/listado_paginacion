/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package modelo;

import java.util.ArrayList;
import java.util.List;

public class producto {
    private int id;
    private String nombre;
    private double precio;
    private String categoria;
    
    public producto(int id, String nombre, double precio, String categoria) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.categoria = categoria;
    }
    
    public producto() {
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public double getPrecio() {
        return precio;
    }
    
    public void setPrecio(double precio) {
        this.precio = precio;
    }
    
    public String getCategoria() {
        return categoria;
    }
    
    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    
    public static List<producto> generarProductos(int cantidad) {
        List<producto> productos = new ArrayList<>();
        String[] categoria = {"Electrónica", "Ropa", "Hogar", "Alimentos", "Juguetes"};
        
        for(int i = 1; i <= cantidad; i++) {
            producto p = new producto(); 
            p.setId(i);
            p.setNombre("Producto " + i);
            p.setPrecio(10 + Math.random() * 90);
            p.setCategoria(categoria[i % categoria.length]);
            productos.add(p);
        }
        return productos;
    }
}