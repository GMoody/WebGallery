<%@page import="java.util.*" %>
<%@page import="java.lang.System.*" %>
<%@page import="main.User" %>
<%@page import="java.sql.*" %>
<%@ page import="functions.Connections" %>

<%
    String login = request.getParameter("username");
    String email = request.getParameter("email");
    String fname = request.getParameter("firstname");
    String lname = request.getParameter("lastname");
    String pass1 = request.getParameter("password");
    String pass2 = request.getParameter("password_confirm");
    int reg;

    if(pass1.equals(pass2)){

        try {
            reg = User.addUser(login,fname,lname,email,pass1);

            switch (reg)
            {
                case 0:
                    %><script>alert("Database error, contact administration!");</script><%
                break;

                case 1:
                    session.setAttribute("user_name",login);
                    %><script>alert("Registration successful!");</script><%
                    %><script>window.location = "../index.jsp"</script><%
                break;

                case 2:
                    %><script>alert("This email is already registered!");</script><%
                break;

                case -1:
                    %><script>alert("Such user is already registered!");</script><%
                break;

                case -2:
                    %><script>alert("Empty or null data entered!");</script><%
                break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e){ e.printStackTrace(); }
                    catch (Exception e){e.printStackTrace();}
    }
    else
    {
        %><script>alert("Incorrect password, please try again!");
                  window.location = window.location.href;</script><%
    }



%>