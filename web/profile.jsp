<%--
  Created by IntelliJ IDEA.
  User: r3dz
  Date: 28.11.2015
  Time: 14:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="functions.Connections"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@ page import="java.sql.ResultSet" %>
<%@page import="java.util.*" %>
<%@page import="main.User_Statistics" %>
<%@ page import="main.User" %>
<%@page import="main.Position" %>
<%
    // Заблокируем доступ к странице незалогиненному пользователю и избежим получения ошибки java.lang.NullPointerException!!!
//    String username="";
//    try { username = (String) session.getAttribute("user_name");
//        if(username == null | username.isEmpty())
//        {
//            session.invalidate();
//            response.sendRedirect("index.jsp");
//        }
//    } catch (Exception ex){}
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <!-- Meta -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Web Gallery">
    <meta name="author" content="G. Tureev, D. Kulakov">

    <!-- CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/webgallery.css"/>

    <!-- JS -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Title -->
    <title>Web Gallery</title>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Mobile display menu-->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Web Gallery</a>
        </div>
        <!-- Mobile display menu END-->

        <!-- Navbar + login modal -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <% try{ if (session.getAttribute("user_name") == null){%>
                <li><a href="register.jsp">Registration</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
                <% }else{ %>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
                <% } }catch (Exception ex){}%>
            </ul>

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">
                <!-- Logged-in -->
                <li class="dropdown">
                    <% if (session.getAttribute("user_name") != null) {%>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("user_name")%><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="profile.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                        <% try{ if(Integer.valueOf(session.getAttribute("position").toString())  == 3){ %>
                        <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
                        <%} }catch (Exception e){}%>
                        <li class="divider"></li>
                        <li><a href="functions/logout.jsp" name="logout_btn"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                    </ul>
                </li>
                <!-- Logged-in end-->

                <!-- NOT Logged-in -->
                <% } else {%>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Log in<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="height: 180px; width: 300px">
                        <div class="loginmodal-container">
                            <form method="post" name="login_form">
                                <input type="text" name="user_email" placeholder="Email">
                                <input type="password" name="pwd" placeholder="Password">
                                <input type="submit" name="log_in_btn" class="login loginmodal-submit" value="Log in">
                            </form>
                            <%
                                if (request.getParameter("log_in_btn") != null) {
                                    request.getRequestDispatcher("functions/login.jsp").include(request, response);
                            %><script>window.location = window.location.href;</script>
                            <%}%>
                        </div>
                    </ul>
                </li>
                <% }%>
                <!-- NOT Logged-in end-->

            </ul>
            <!-- Profile end-->

        </div>
        <!-- Navbar + login modal END-->
    </div>
    <!-- /.container -->
</nav>
<!-- Navigation END-->




<!-- Page Content -->
<div class="container">

    <!-- Page Heading -->
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Account details
                <smaall></smaall>
            </h1>
        </div>
    </div>
    <!-- /.row -->


    <br>
    <div class="container-fluid well span6">
        <div class="row-fluid">
            <div class="span2" style="float:left;">
                <img style="width:150px; height: 150px;" src="http://www.marketingextremist.com/wp-content/uploads/2014/05/How-to-Change-a-Username-in-WordPress.jpg" class="img-circle">

                <h4 style="margin-left: 40px;"><%=session.getAttribute("user_name").toString()%></h4>
            </div>

            <div class="span8" style="float:left; margin-left: 40px;">
                <h5>Position: <%
                    //out.println(Position.getPositionInfo(Integer.parseInt(session.getAttribute("position").toString())));
                    out.println(User.users.size());
                    out.println(User.getUsers().size());
                    for (User user:User.users){
                        out.println(user.getEmail().toString());
                    }
                   //if(Integer.parseInt(session.getAttribute("position").toString()) == 1){out.println("User");};
                %></h5>
                <h5>First name: <% out.print("Work in progress");//out.print(User.getUserInfo((String) session.getAttribute("email")).getFirst_name().toString()); %></h5>
                <h5>Last name:</h5>
                <h5>Password:</h5>
                <h5>Email:</h5>
                <h5>Location:</h5>

            </div>

            <div class="span2" style="float:right;">
                <td class="tg-baqh" colspan="2"><input type="submit" class="btn btn-primary" value="Edit profile"></td>
            </div>

            <div class="span3" style="float:right; margin-right: -101px;margin-top: 45px;">
                <td class="tg-baqh" colspan="2"><input type="submit" class="btn btn-primary" value="View gallery"></td>
            </div>
                //push

        </div>
    </div>



    <hr>


    <!-- Footer -->
    <footer>
        <div class="row">
            <div class="col-lg-12">
                <p>Copyright &copy; Web Gallery 2015</p>
            </div>
        </div>
        <!-- /.row -->
    </footer>

</div>
<!-- /.container -->

</body>

</html>