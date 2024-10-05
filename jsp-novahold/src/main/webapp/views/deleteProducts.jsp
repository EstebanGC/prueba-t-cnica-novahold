<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<html>
<head>
    <title>Eliminar productos</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body style="background: linear-gradient(to right, #003366, #66ccff); color: #333; font-family: Arial, sans-serif; margin: 0; padding: 20px;">
    <h1>Eliminar productos</h1>

    <form method="post" action="deleteProduct.jsp">
        <label for="productId">Id del producto:</label>
        <input type="text" id="productId" name="productId" required><br><br>
        <button type="submit">Eliminar producto</button>
    </form>

    <%
        // Verificar si es un POST para eliminar el producto
        if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                // Obtener el ID del producto del formulario
                String productId = request.getParameter("productId");

                // URL del endpoint de la API para eliminar el producto
                URL url = new URL("http://localhost:8080/delete/product/" + productId);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("DELETE");
                con.setRequestProperty("Accept", "application/json");

                // Leer la respuesta de la API
                int responseCode = con.getResponseCode();
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    out.println("<h3>Product deleted successfully!</h3>");
                } else {
                    out.println("<h3>Failed to delete product. Response code: " + responseCode + "</h3>");
                }

                // Cerrar la conexión
                con.disconnect();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3>Error deleting product: " + e.getMessage() + "</h3>");
            }
        }
    %>
</body>
</html>
