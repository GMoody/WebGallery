<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.User" %>
<%@ page import="main.Position" %>

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
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
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
                <li><a href="index.jsp">Main</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
            </ul>

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">
                <!-- Logged-in -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("user_name")%><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="profile.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                        <% if(Integer.valueOf(session.getAttribute("position").toString())  == 3){ %>
                        <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
                        <%}%>
                        <li class="divider"></li>
                        <li><a href="functions/logout.jsp" name="logout_btn"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                    </ul>
                </li>
                <!-- Logged-in end-->
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
    <%--<div class="row">--%>
        <%--<div class="col-lg-12">--%>
            <%--<h1 class="page-header">Account details--%>
                <%--<small></small>--%>
            <%--</h1>--%>
        <%--</div>--%>
    <%--</div>--%>
    <!-- /.row -->


    <br>
    <div class="container-fluid well span6">
        <div class="row-fluid">
            <div class="span2" style="float:left;">
                <img style="width:150px; height: 150px;" src="http://www.marketingextremist.com/wp-content/uploads/2014/05/How-to-Change-a-Username-in-WordPress.jpg" class="img-circle">
                <h4 style="margin-left: 35px;"><%=session.getAttribute("user_name")%></h4> <%--Отступ работает у всех по-разному--%>
            </div>

            <div class="span8" style="float:left; margin-left: 40px;">
                <h5>Position: <% out.println(Position.getPositionInfo(User.getUserInfo(session.getAttribute("email").toString()).getId_position()).getPosition()); %></h5>
                <h5>First name: <% out.print(User.getUserInfo(session.getAttribute("email").toString()).getFirst_name()); %></h5>
                <h5>Last name: <% out.print(User.getUserInfo(session.getAttribute("email").toString()).getLast_name()); %></h5>
                <h5>Email: <% out.print(User.getUserInfo(session.getAttribute("email").toString()).getEmail()); %></h5>
            </div>

            <div class="span2" style="float:right;">
                <td class="tg-baqh" colspan="2"><input type="submit" class="btn btn-primary" value="Edit profile"></td>
            </div>

            <div class="span3" style="float:right; margin-right: -101px;margin-top: 45px;">
                <td class="tg-baqh" colspan="2"><input type="submit" class="btn btn-primary" value="View gallery"></td>
            </div>

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