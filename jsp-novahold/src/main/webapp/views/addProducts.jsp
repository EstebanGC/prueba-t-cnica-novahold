<%@ page import="java.io.OutputStreamWriter, java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<html>
<head>
    <title>Agregar Producto</title>
</head>
<body>
    <a href="index.jsp">Volver a la pagina principal</a>
    <h1>Agregar Producto</h1>

    <!-- Formulario para ingresar datos del producto -->
    <form method="POST">
        Nombre: <input type="text" name="name" required /><br />
        Disponible:
        <select name="available" required>
            <option value="true">Si</option>
            <option value="false">No</option>
        </select><br />
        Unidades minimas: <input type="number" name="minUnits" min="0" required /><br />
        Unidades maximas: <input type="number" name="maxUnits" min="1" required /><br />
        <input type="submit" value="Agregar Producto" />
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            Boolean available = Boolean.valueOf(request.getParameter("available"));
            int minUnits = Integer.parseInt(request.getParameter("minUnits"));
            int maxUnits = Integer.parseInt(request.getParameter("maxUnits"));

            try {
                // URL del endpoint de la API para el POST
                String apiUrl = "http://localhost:8080/save/product";

                URL url = new URL(apiUrl);

                HttpURLConnection con = (HttpURLConnection) url.openConnection();

                // Configurar la conexión como POST
                con.setRequestMethod("POST");
                con.setRequestProperty("Content-Type", "application/json; utf-8");
                con.setRequestProperty("Accept", "application/json");
                con.setDoOutput(true);

                String jsonInputString = "{\"name\": \"" + name + "\", \"available\": " + available + ", \"minUnits\": " + minUnits + ", \"maxUnits\": " + maxUnits + "}";

                try(OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream())) {
                    writer.write(jsonInputString);
                    writer.flush();
                }

                // Leer la respuesta de la API
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer content = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
                in.close();
                con.disconnect();

                // Mostrar el resultado de la petición POST
                out.println("<h3>Producto agregado correctamente:</h3>");
                out.println("<pre>" + content.toString() + "</pre>");
            } catch (Exception e) {
                out.println("<h3>Error al agregar producto:</h3>");
                out.println("<pre>" + e.getMessage() + "</pre>");
            }
        }
    %>
</body>
</html>