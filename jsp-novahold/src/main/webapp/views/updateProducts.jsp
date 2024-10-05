<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, java.net.HttpURLConnection, java.io.OutputStream" %>
<html>
<head>
    <title>Update Product</title>
</head>
<body>
    <h1>Update Product</h1>

    <form method="post" action="updateProduct.jsp">
        <label for="productId">Product ID:</label>
        <input type="text" id="productId" name="productId" required><br><br>

        <label for="name">Nombre:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="available">Disponible (true/false):</label>
        <input type="text" id="available" name="available" required><br><br>

        <label for="minUnits">Unidades minimas:</label>
        <input type="number" id="minUnits" name="minUnits" required><br><br>

        <label for="maxUnits">Unidades maximas:</label>
        <input type="number" id="maxUnits" name="maxUnits" required><br><br>

        <button type="submit">Editar producto</button>
    </form>

    <%
        // Verificar si es un POST para actualizar el producto
        if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                // Obtener los datos del formulario
                String productId = request.getParameter("productId");
                String name = request.getParameter("name");
                String available = request.getParameter("available");
                String minUnits = request.getParameter("minUnits");
                String maxUnits = request.getParameter("maxUnits");

                // Construir el JSON para enviar al API
                String jsonInputString = "{"
                        + "\"productId\":" + productId + ","
                        + "\"name\":\"" + name + "\","
                        + "\"available\":" + available + ","
                        + "\"minUnits\":" + minUnits + ","
                        + "\"maxUnits\":" + maxUnits
                        + "}";

                // URL del endpoint de la API para actualizar el producto
                URL url = new URL("http://localhost:8080/update/product");
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("PUT");
                con.setRequestProperty("Content-Type", "application/json; utf-8");
                con.setRequestProperty("Accept", "application/json");
                con.setDoOutput(true);

                // Enviar el cuerpo de la petición con los datos del producto en formato JSON
                try (OutputStream os = con.getOutputStream()) {
                    byte[] input = jsonInputString.getBytes("utf-8");
                    os.write(input, 0, input.length);
                }

                // Leer la respuesta del API
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
                StringBuilder apiResponse = new StringBuilder();
                String responseLine = null;
                while ((responseLine = br.readLine()) != null) {
                    apiResponse.append(responseLine.trim());
                }

                // Mostrar el resultado en la página
                out.println("<h3>Product Updated Successfully!</h3>");
                out.println("<pre>" + apiResponse.toString() + "</pre>");

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3>Error updating product: " + e.getMessage() + "</h3>");
            }
        }
    %>
</body>
</html>
