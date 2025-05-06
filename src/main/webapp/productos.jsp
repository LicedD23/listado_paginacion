<%-- 
    Document   : productos
    Created on : 30/04/2025, 11:35:48 a. m.
    Author     : Personal
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="modelo.producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Listado de Productos</title>
        
        <style>
           
            
           
            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: 'Inter', sans-serif;
                background-color:#8cc9ff;
                color:black;
                line-height: 1.6;
                padding: 2rem;
                
            }
            
            .container {
                max-width: 1000px;
                margin: 0 auto;
                background-color:white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                padding: 2rem;
            }
            
            h1 {
                color: var(--dark);
                text-align: center;
                margin-bottom: 1.5rem;
                font-weight: 600;
                font-size: 1.8rem;
            }
            
            .filtros {
                margin-bottom: 1.5rem;
                padding: 1rem;
                background-color:#c6d4e1;
                border-radius: 8px;
            }
            
            .filtros form {
                display: flex;
                align-items: center;
                gap: 0.8rem;
            }
            
            .filtros label {
                font-weight: 500;
                color:#191013 ;
            }
            
            .filtros select {
                padding: 8px 12px;
                border: 1px solid #E0E0E0;
                border-radius: 6px;
                background-color: white;
                font-family: inherit;
                font-size: 0.9rem;
                cursor: pointer;
                outline: none;
            }
            
            .filtros select:focus {
                border-color:#8cc9ff ;
            }
            
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-bottom: 1.5rem;
            }
            
            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #E0E0E0;
            }
            
            th {
                background-color:#44749d;
                color: #191013;
                font-weight: 500;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            tr:hover {
                background-color:#c6d4e1 ;
            }
            
            .precio {
                font-weight: 500;
                color: var(--dark);
            }
            
            .categoria {
                background-color: #8cc9ff;
                color: var(--primary);
                padding: 3px 8px;
                border-radius: 4px;
                font-size: 0.8rem;
                font-weight: 500;
            }
            
            .paginacion {
                display: flex;
                justify-content: center;
                margin-top: 1.5rem;
            }
            
            .paginacion p {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-size: 0.9rem;
                color: var(--gray);
            }
            
            .paginacion a {
                text-decoration: none;
                color: var(--primary);
                padding: 5px 10px;
                border-radius: 4px;
                transition: all 0.2s ease;
            }
            
            .paginacion a:hover {
                background-color: var(--light-accent);
            }
            
            .paginacion strong {
                background-color: var(--primary);
                color: white;
                padding: 5px 10px;
                border-radius: 4px;
            }
            
            .empty-message {
                text-align: center;
                padding: 1.5rem;
                color: var(--gray);
                font-style: italic;
            }
            
            .icon {
                margin-right: 5px;
                font-size: 0.9rem;
            }
             /* Responsive design */
            @media (max-width: 768px) {
                body {
                    padding: 1rem;
                }
                
           
                
                .container {
                    padding: 1rem;
                }
                
                table {
                    display: block;
                    overflow-x: auto;
                }
                
                .filtros form {
                    flex-direction: column;
                    align-items: flex-start;
                }
                
                .filtros select {
                    width: 100%;
                }
            
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Listado de Productos</h1>
            <%
                List<producto> productos = (List<producto>) request.getAttribute("productos");
                Set<String> categoria = (Set<String>) request.getAttribute("categoria");
                String categoriaActual = (String) request.getAttribute("categoriaActual");
                Integer paginaActualObj = (Integer) request.getAttribute("paginaActual");
                Integer totalPaginasObj = (Integer) request.getAttribute("totalPaginas");
                
                if (productos == null) productos = java.util.Collections.emptyList();
                if (categoria == null) categoria = java.util.Collections.emptySet();
                int paginaActual = (paginaActualObj != null) ? paginaActualObj : 1;
                int totalPaginas = (totalPaginasObj != null) ? totalPaginasObj : 1;
            %>
            
            <div class="filtros">
                <form action="productos" method="get">
                    <label>Filtrar por categoría:</label>
                    <select name="categoria" onchange="this.form.submit()">
                        <option value="">Todas las categorías</option>
                        <% for(String cat : categoria) { %>
                            <option value="<%= cat %>" <%= (cat.equals(categoriaActual) ? "selected" : "") %>>
                                <%= cat %>
                            </option>
                        <% } %>
                    </select>
                </form>
            </div>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Categoría</th>
                </tr>
                <% if(productos.isEmpty()) { %>
                    <tr>
                        <td colspan="4" class="empty-message">
                            <i class="fas fa-info-circle icon"></i> No hay productos disponibles
                        </td>
                    </tr>
                <% } else { %>
                    <% for(producto p : productos) { %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= p.getNombre() %></td>
                            <td class="precio">$<%= String.format("%.2f", p.getPrecio()) %></td>
                            <td><span class="categoria"><%= p.getCategoria() %></span></td>
                        </tr>
                    <% } %>
                <% } %>
            </table>
            
            <div class="paginacion">
                <% if(totalPaginas > 1) { %>
                    <p>
                        Página <%= paginaActual %> de <%= totalPaginas %>
                        <% if(paginaActual > 1) { %>
                            <a href="productos?pagina=<%= paginaActual - 1 %><%= (categoriaActual != null ? "&categoria=" + categoriaActual : "") %>">
                                Anterior
                            </a>
                        <% } %>
                        
                        <% for(int i = 1; i <= totalPaginas; i++) { %>
                            <% if(i == paginaActual) { %>
                                <strong><%= i %></strong>
                            <% } else { %>
                                <a href="productos?pagina=<%= i %><%= (categoriaActual != null ? "&categoria=" + categoriaActual : "") %>"><%= i %></a>
                            <% } %>
                        <% } %>
                        
                        <% if(paginaActual < totalPaginas) { %>
                            <a href="productos?pagina=<%= paginaActual + 1 %><%= (categoriaActual != null ? "&categoria=" + categoriaActual : "") %>">
                                Siguiente
                            </a>
                        <% } %>
                    </p>
                <% } %>
            </div>
        </div>
    </body>
</html>