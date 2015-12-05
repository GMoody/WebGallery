<%@page import="functions.Connections"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page import="java.sql.ResultSet" %>

<%
    try {
        ResultSet user_data = Connections.getUserInfo(request.getParameter("user_email"));
        if (user_data.next()){
            if (BCrypt.checkpw(request.getParameter("pwd"), user_data.getString(7))) {
                session.setAttribute("user_name", user_data.getString(3));
                session.setAttribute("position", user_data.getInt(2));
                session.setAttribute("email", user_data.getString(6));
                user_data.close();
            }
            else {
                %><script>alert("Password doesn't match!");</script><%
            }
        }else {
            %><script>alert("There's no such user!");</script><%
        }
    }catch (Exception e) {
        %><script>alert("Login error, contact system administrator!");</script><%
    }
%>
