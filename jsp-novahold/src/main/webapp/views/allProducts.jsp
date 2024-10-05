<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<html>
<head>
    <title>Productos</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body style="background: linear-gradient(to right, #003366, #66ccff); color: #333; font-family: Arial, sans-serif; margin: 0; padding: 20px;">
    <a href="addProducts.jsp">Agregar Nuevo Producto</a>
    <h1>Lista de Productos</h1>
    <%
        try {
            // URL del endpoint de la API
            String apiUrl = "http://localhost:8080/get/all/products";

            // Crear el objeto URL
            URL url = new URL(apiUrl);

            // Abrir la conexión
            HttpURLConnection con = (HttpURLConnection) url.openConnection();

            // Configurar la petición como GET
            con.setRequestMethod("GET");

            // Leer la respuesta de la API
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer content = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }

            // Cerrar los flujos
            in.close();
            con.disconnect();

            // Parsear la respuesta JSON
            JSONArray products = new JSONArray(content.toString());

            // Generar la tabla con los productos
    %>
            <table border="1">
                <thead>
                    <tr>
                        <th>Id del producto</th>
                        <th>Nombre</th>
                        <th>Disponible</th>
                        <th>Unid min</th>
                        <th>Unid max</th>
                    </tr>
                </thead>
                <tbody>
    <%
            // Iterar sobre el array JSON y construir filas de la tabla
            for (int i = 0; i < products.length(); i++) {
                JSONObject product = products.getJSONObject(i);
    %>
                    <tr>
                        <td><%= product.getInt("productId") %></td>
                        <td><%= product.getString("name") %></td>
                        <td><%= product.getBoolean("available") ? "Yes" : "No" %></td>
                        <td><%= product.getInt("minUnits") %></td>
                        <td><%= product.getInt("maxUnits") %></td>
                    </tr>
    <%
            }
    %>
                </tbody>
            </table>
    <%
        } catch (Exception e) {
            out.println("Error al obtener datos de la API: " + e.getMessage());
        }
    %>
</body>
</html>
