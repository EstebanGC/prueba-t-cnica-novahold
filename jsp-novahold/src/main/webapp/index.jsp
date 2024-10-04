<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<html>
<head>
    <title>Products API</title>
</head>
<body>
    <h1>API data</h1>
    <%
        // URL del endpoint de la API
        String apiUrl = "http://localhost:8080/get/all/products";

        // Crear el objeto URL
        URL url = new URL(apiUrl);

        // Abrir la conexión
        HttpURLConnection con = (HttpURLConnection) url.openConnection();

        // Configurar la petición como GET
        con.setRequestMethod("GET");

        // Reading API answer
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer content = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }

        // Cerrar los flujos
        in.close();
        con.disconnect();

        // Mostrar la respuesta en la página JSP
        out.println("<pre>" + content.toString() + "</pre>");
    %>
</body>
</html>