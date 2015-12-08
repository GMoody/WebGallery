
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
    <title>Web Gallery - Picture info</title>

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

            <a class="navbar-brand" href="picture.jsp?picture=<%=request.getParameter("picture")%>">Picture</a>
        </div>
        <!-- Mobile display menu END-->

        <!-- Navbar + login modal -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <!-- Navbar -->
            <ul class="nav navbar-nav">
                <% if (session.getAttribute("user_name") == null){%>
                    <li><a href="register.jsp">Registration</a></li>
                    <li><a href="index.jsp">Main</a></li>
                    <li><a href="#">Contact</a></li>
                <% }else{ %>
                    <li><a href="index.jsp">Main</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Contact</a></li>
                <% } %>
            </ul>
            <!-- Navbar END -->

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">

                <!-- Logged-in -->
                <li class="dropdown">
                    <% if (session.getAttribute("user_name") != null) {%>
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("user_name")%><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="profile.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                            <li><a href="gallery.jsp"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span> Gallery</a></li>
                            <% if(Integer.valueOf(session.getAttribute("position").toString())  == 2){ %>
                                <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
                            <%}%>
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
                            <form method="post" action="functions/login.jsp" name="login_form">
                                <input type="text" name="user_email" placeholder="Email">
                                <input type="password" name="pwd" placeholder="Password">
                                <input type="submit" name="log_in_btn" class="login loginmodal-submit" value="Log in">
                            </form>
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
            <h1 class="page-header">Tool menu
                <small>Secondary Text</small>
            </h1>
        </div>
    </div>
    <!-- /.row -->



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