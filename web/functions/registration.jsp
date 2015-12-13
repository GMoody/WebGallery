<%@page import="main.User" %>
<%@page import="java.sql.*" %>

<%
    String login = request.getParameter("username");
    String email = request.getParameter("email");
    String fname = request.getParameter("firstname");
    String lname = request.getParameter("lastname");
    String pass1 = request.getParameter("password");
    String pass2 = request.getParameter("password_confirm");

    if(pass1.equals(pass2))
        try {
            int reg = User.addUser(login,fname,lname,email,pass1);

            switch (reg){
                case 0:
                    %><script>alert("Database error, contact administration!");</script><%
                break;

                case 1:
                    %><script>alert("Registration successful!");</script><%
                        session.setAttribute("user_name",login);
                        session.setAttribute("position", 1);
                        session.setAttribute("email", email);
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
        } catch (ClassNotFoundException e){
            e.printStackTrace();
        }

    else{
        %><script>alert("Incorrect password, please try again!");
                  window.location = window.location.href;</script><%
    }
%>