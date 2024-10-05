<%@ page import="java.io.OutputStreamWriter, java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<html>
<head>
    <title>Agregar Producto</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body style="background: linear-gradient(to right, #003366, #66ccff); color: #333; font-family: Arial, sans-serif; margin: 0; padding: 20px;">
    <a href="index.jsp">Volver a la pagina principal</a>
    <h1>Agregar Producto</h1>


    <form method="POST">
        <label for="name">Nombre:</label>
        <input type="text" id="name" name="name" required /><br /><br />

        <label for="available">Disponible:</label>
        <select id="available" name="available" required>
            <option value="true">Si</option>
            <option value="false">No</option>
        </select><br /><br />

        <label for="minUnits">Unidades minimas:</label>
        <input type="number" id="minUnits" name="minUnits" min="0" required /><br /><br />

        <label for="maxUnits">Unidades maximas:</label>
        <input type="number" id="maxUnits" name="maxUnits" min="1" required /><br /><br />

        <button type="submit">Agregar producto</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            Boolean available = Boolean.valueOf(request.getParameter("available"));
            int minUnits = Integer.parseInt(request.getParameter("minUnits"));
            int maxUnits = Integer.parseInt(request.getParameter("maxUnits"));

            try {
                String apiUrl = "http://localhost:8080/save/product";

                URL url = new URL(apiUrl);

                HttpURLConnection con = (HttpURLConnection) url.openConnection();

                con.setRequestMethod("POST");
                con.setRequestProperty("Content-Type", "application/json; utf-8");
                con.setRequestProperty("Accept", "application/json");
                con.setDoOutput(true);

                String jsonInputString = "{\"name\": \"" + name + "\", \"available\": " + available + ", \"minUnits\": " + minUnits + ", \"maxUnits\": " + maxUnits + "}";

                try(OutputStreamWriter writer = new OutputStreamWriter(con.getOutputStream())) {
                    writer.write(jsonInputString);
                    writer.flush();
                }

                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer content = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
                in.close();
                con.disconnect();

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