<%--
  Created by IntelliJ IDEA.
  User: r3dz
  Date: 23.11.2015
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    out.println(login + email + fname + lname + pass1 + pass2);
    int reg = 0;

    if(pass1.equals(pass2)){

        reg = User.addUser(login,fname,lname,email,pass1);
        System.out.println(email);
        //
        switch (reg)
        {
            case 0: %><script>alert("Database error, contact administration!");</script><%;break;
            case 1: %><script>alert("Registration successful!");</script><%;
                session.setAttribute("login",login);
                response.sendRedirect("index.jsp");
                break;
            case -1: %><script>alert("Such user is already registered!");</script><%;break;
            case -2: %><script>alert("Empty or null data entered!");</script><%;break;
            default: out.println("something went wrong, reg:"+reg);
        }
            %><script>window.location = window.location.href;</script><%
    }
    else
    {
        response.sendRedirect("register.jsp");
        %>
            <script>alert("Incorrect password, please try again!");</script>
        <%
    }


%>