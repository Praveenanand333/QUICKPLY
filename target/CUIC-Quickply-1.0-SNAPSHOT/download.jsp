<%@ page language="java" contentType="application/octet-stream; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>

<%
    String fileName = request.getParameter("fileName");

    if (fileName != null) {
        // Set the content type to force the browser to treat the file as an attachment
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        // Read the file content and write it to the response output stream
        try (InputStream inputStream = new FileInputStream(new File("path/to/your/files/directory", fileName));
             OutputStream outputStream = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    } else {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    }
%>
