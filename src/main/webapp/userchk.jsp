<%-- 
    Document   : userchk.jsp
    Created on : 26-Nov-2023, 12:07:50 am
    Author     : nish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>USER REGISTRATION COMPLETION</title>
    </head>
    <body>
        <%
            try {
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "cuic", "1234");
                String user = request.getParameter("usern");
                String pass = request.getParameter("pass");
                PreparedStatement ps = con.prepareStatement("select type,info from users where username=? and password=?");
                ps.setString(1, user);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();
                int size = 0;
                while(rs.next()){
                    size += 1;
                }
                if(size == 0){
                    response.sendRedirect("usernotfound.jsp");
                }
                ps = con.prepareStatement("select type,info from users where username=? and password=?");
                ps.setString(1, user);
                ps.setString(2, pass);
                rs = ps.executeQuery();
                
                rs.next();
                
                String type = rs.getString("type");
                String info = rs.getString("info");
                session.setAttribute("un",user);
                session.setAttribute("ps",pass);
                if(info.equals("YES")){
                    if(type.equals("admin")){
                        response.sendRedirect("admindash.jsp");
                    }
                    else{
                        response.sendRedirect("userdash.jsp");
                    }
                }
                else{
                    if(type.equals("admin")){
                        response.sendRedirect("admindash.jsp");
                    }
                    else{
                        response.sendRedirect("userinfo.jsp");
                    }
                }
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
