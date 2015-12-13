<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!-- Title -->
    <title>Web Gallery - About</title>

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

            <a class="navbar-brand">About</a>
        </div>
        <!-- Mobile display menu END-->

        <!-- Navbar + login modal -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <!-- Navbar -->
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">Main</a></li>
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%=session.getAttribute("user_name")%><b class="caret"></b></a>
                        <!-- Dropdown menu -->
                        <ul class="dropdown-menu">
                            <li><a href="profile.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                            <li><a href="gallery.jsp?user=<%=session.getAttribute("user_name")%>"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span> Gallery</a></li>
                            <%if(Integer.parseInt(session.getAttribute("position").toString()) == 2){ %>
                                <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
                            <%}%>
                            <li class="divider"></li>
                            <li><a href="functions/logout.jsp" name="logout_btn"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                        </ul>
                        <!-- Dropdown menu END -->
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
    <div class="panel panel-default">
        <!-- Panel Header -->
        <div class="panel-heading">
            <div class="row">
                <div class="col-lg-12">
                    <h1>WebGallery project: <small>RAM0122	Veebiprogrammeerimine I - projekt</small></h1>
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- Panel Header END -->

        <!-- Panel Body -->
        <div class="panel-body">
            <h3>TTÜ Virumaa Kolledž: RDIR51</h3>
            <div class="well">
                <h4><span class="glyphicon glyphicon-user"></span> Deniss Kulakov -
                    <span class="glyphicon glyphicon-envelope"></span> <a href="mailto:deniss.kulakov@hotmail.com" target="_top">deniss.kulakov@hotmail.com</a></h4>

                <h4><span class="glyphicon glyphicon-user"></span> Grigory Tureev -
                    <span class="glyphicon glyphicon-envelope"></span> <a href="mailto:g.tureev@gmail.com" target="_top">g.tureev@gmail.com</a></h4>
            </div>
        </div>
        <!-- Panel Body END -->
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