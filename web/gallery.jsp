<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.User" %>

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
    <title>Web Gallery - Gallery</title>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">

        <!-- Mobile display menu-->
        <div class="navbar-header">
            <!-- Options button-->
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!-- Options button END-->

            <a class="navbar-brand" href="index.jsp">Web Gallery</a>
        </div>
        <!-- Mobile display menu END-->

        <!-- Navbar + login modal -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <!-- Navbar -->
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">Main</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
            <!-- Navbar END -->

            <!-- Profile -->
            <ul class="nav navbar-nav navbar-right">
                <!-- NOT Logged-in -->
                <% if (session.getAttribute("user_name") == null) {%>
                    <li><a href="register.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
                    <li class="dropdown disp_none"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-log-in"></span> Login<b class="caret"></b></a>
                        <!-- Dropdown menu -->
                        <ul class="dropdown-menu" style="height: 180px; width: 300px">
                            <div class="loginmodal-container">
                                <form method="post" action="functions/login.jsp" name="login_form">
                                    <input type="text" name="user_email" placeholder="Email">
                                    <input type="password" name="pwd" placeholder="Password">
                                    <input type="submit" name="log_in_btn" class="login loginmodal-submit" value="Log in">
                                </form>
                            </div>
                        </ul>
                        <!-- Dropdown menu END -->
                    </li>

                <!-- NOT Logged-in end-->
                <%}else{%>

                <!-- Logged-in -->
                <li class="dropdown disp_none">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("user_name")%><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="profile.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                        <li><a href="gallery.jsp"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span> Gallery</a></li>
                        <%if(Integer.parseInt(session.getAttribute("position").toString()) == 2){ %>
                            <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
                        <%}%>
                        <li class="divider"></li>
                        <li><a href="functions/logout.jsp" name="logout_btn"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                    </ul>
                </li>
                <!-- Logged-in end-->
                <%}%>
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

    <%
        String user_name;
        boolean logged_in = false, display_flag = true, same_user = false;

        if(session.getAttribute("user_name") != null)
            logged_in = true;

        if(request.getAttribute("user") != null){
            user_name = User.getUserInfo(Integer.parseInt(request.getAttribute("user").toString())).getUser_name();

            if(logged_in){
                if(user_name.equals(session.getAttribute("user_name").toString()))
                 same_user = true;
            }
        }else if(logged_in){

        }else{
            display_flag = false;
        }

    %>
    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#gallery">Gallery</a></li>
        <li><a data-toggle="tab" href="#upload">Picture upload</a></li>
    </ul>

    <div class="tab-content">
        <div id="gallery" class="tab-pane fade in active">
            <h3><%=session.getAttribute("user_name")%> gallery</h3>
            <p>Pictures</p>
        </div>
        <div id="upload" class="tab-pane fade">
            <h3>Pictures upload</h3>
            <p>Upload by single picture with description and category dropdown</p>
        </div>
    </div>






    <hr>

    <!-- Footer -->
    <footer>
        <div class="row">
            <div class="col-lg-12">
                <p align="center">Copyright &copy; Web Gallery 2015</p>
            </div>
        </div>
        <!-- /.row -->
    </footer>
    <!-- Footer END-->

</div>
<!-- /.container -->

</body>

</html>