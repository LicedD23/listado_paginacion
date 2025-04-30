<%-- 
    Document   : productos
    Created on : 30/04/2025, 11:35:48 a. m.
    Author     : Personal
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset=UTF-8">
        <title>Listado de Productos</title>
        <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .paginacion { margin-top: 20px; }
        .paginacion a { margin-right: 5px; }
        .filtros { margin-bottom: 20px; }
        </style>
</head>
<body>
    <h1>Listado de Productos</h1>
    <%
        List<producto> productos = (List<producto>)
    request.getAttribute("productos");
        Set<String> categorias = (Set<String>)
    request.getAttribute("categorias");
        String categoriaActual = (String)
request.getAttribute("categoriaActual");
        int paginaActual = (int) request.getAttribute("paginaActual");
        int totalPaginas = (int) request.getAttribute("totalPaginas");
    %>
    
    <div class="filtros">
        <form action="productos" method="get">
            <label>Filtrar por categoría:</label>
            <select name="categoria" onchange="this.form.submit()">
                <option value="">Todas las categorías</option>
                <% for(String cat : categorias) { %>
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
            <td colspan="4">No hay productos disponibles</td>
        </tr>
    <% } else { %>
        <% for(producto p : productos) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getNombre() %></td>
                <td>$<%= String.format("%.2f", p.getPrecio())
%></td>
                <td><%= p.getCategoria() %></td>
            </tr>
        <% } %>
    <% } %>
</table>
<div class="paginacion">
    <% if(totalPaginas > 1) { %>
        <p>
            Página <%= paginaActual %> de <%= totalPaginas %>
            <% if(paginaActual > 1) { %>
                <a href="productos?pagina=<%= paginaActual - 1 %><%= (categoriaActual != null ? "&categoria=" + categoriaActual : "")
%>">Anterior</a>
                <% } %>
                <% for(int i = 1; i <= totalPaginas; i++) { %>
                    <% if(i == paginaActual) { %>
                        <strong><%= i %></strong>
                    <% } else { %>
                        <a href="productos?pagina=<%= i %><%= (categoriaActual != null ? "&categoria=" + categoriaActual : "") %>"><%=
i %></a>
                    <% } %>
                <% } %>
                <% if(paginaActual < totalPaginas) { %>
                    <a href="productos?pagina=<%= paginaActual + 1 %><%= (categoriaActual != null ? "&categoria=" + categoriaActual : "")
%>">Siguiente</a>
                <% } %>
            </p>
    <% } %>
    </div>
</body>
</html>

