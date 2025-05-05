/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import modelo.producto;

@WebServlet("/productos")
public class ProductosServlet extends HttpServlet {
    private static final List<producto> PRODUCTOS = producto.generarProductos(50);
    private static final int ITEMS_POR_PAGINA = 10;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pagina = 1;
        String categoria = request.getParameter("categoria");
        
        if(request.getParameter("pagina") != null) {
            try {
                pagina = Integer.parseInt(request.getParameter("pagina"));
                if(pagina < 1) pagina = 1;
            } catch(NumberFormatException e) {
            }
        }
        
        List<producto> productosFiltrados;
        if(categoria != null && !categoria.isEmpty()) {
            productosFiltrados = PRODUCTOS.stream()
                .filter(p -> p.getCategoria().equals(categoria))
                .collect(Collectors.toList());
        } else {
            productosFiltrados = PRODUCTOS;
        }
        
        int totalProductos = productosFiltrados.size();
        int totalPaginas = (int) Math.ceil((double) totalProductos / ITEMS_POR_PAGINA);
        
        if(totalPaginas == 0) totalPaginas = 1;
        
        if(pagina > totalPaginas) pagina = totalPaginas;
        
        int inicio = (pagina - 1) * ITEMS_POR_PAGINA;
        int fin = Math.min(inicio + ITEMS_POR_PAGINA, totalProductos);
        
        if(inicio >= totalProductos) {
            inicio = 0;
            fin = Math.min(ITEMS_POR_PAGINA, totalProductos);
            pagina = 1;
        }
        
        List<producto> productosActuales = productosFiltrados.subList(inicio, fin);
        
        Set<String> categorias = PRODUCTOS.stream()
            .map(producto::getCategoria)
            .collect(Collectors.toSet());
        
        request.setAttribute("productos", productosActuales);
        request.setAttribute("categorias", categoria);
        request.setAttribute("categoriaActual", categoria);
        request.setAttribute("paginaActual", pagina);
        request.setAttribute("totalPaginas", totalPaginas);
        
        request.getRequestDispatcher("/productos.jsp").forward(request, response);
    }
}
