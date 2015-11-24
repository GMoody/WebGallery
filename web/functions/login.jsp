<%@page import="functions.Connections"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    ResultSet user_data = null;
    try {
        user_data = Connections.getUserInfo(request.getParameter("user_email"));
        if (user_data.next()){
            if (BCrypt.checkpw(request.getParameter("pwd"), user_data.getString(7))) {
                session.setAttribute("user_name", user_data.getString(3));
                session.setAttribute("position", user_data.getInt(2));
                user_data.close();
            }
            else {
            %><script>alert("Password doesn't match!");</script><%
            }
        }
        else {
            %><script>alert("There's no such user!");</script><%
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
