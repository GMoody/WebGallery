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

    <!-- Title -->
    <title>Web Gallery</title>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
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
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <% if (session.getAttribute("email") == null) {  %>
                <li><a href="#">Registration</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
                <% }else{ %>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
                <% } %>
            </ul>

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <%
                        if (session.getAttribute("email") != null) {
                    %>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("fname")%>  <%= session.getAttribute("lname")%><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                        <%
                            if(Integer.valueOf(session.getAttribute("position").toString())  == 3){ %>
                        <li><a href="#"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li><%
                        }
                    %>
                        <li class="divider"></li>
                        <li><a href="#" name="logout_btn"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                    </ul>
                </li>
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
                                   // request.getRequestDispatcher("/functions/login.jsp").include(request, response);
                                %><script>window.location = window.location.href;</script><%
                            }
                        %>
                        </div>
                    </ul>
                </li>
                <% }%>
            </ul>
            <!-- Profile end-->

        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>

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

    <!-- Projects Row -->
    <div class="row">
        <div class="col-md-3 portfolio-item">
            <a href="#"><img class="img-responsive" src="http://placehold.it/750x450" alt=""></a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#"><img class="img-responsive" src="http://placehold.it/750x450" alt=""></a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#"><img class="img-responsive" src="http://placehold.it/750x450" alt=""></a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#"><img class="img-responsive" src="http://placehold.it/750x450" alt=""></a>
        </div>
    </div>
    <!-- /.row -->

    <!-- Projects Row -->
    <div class="row">
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
    </div>
    <!-- /.row -->

    <!-- Projects Row -->
    <div class="row">
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
        <div class="col-md-3 portfolio-item">
            <a href="#">
                <img class="img-responsive" src="http://placehold.it/750x450" alt="">
            </a>
        </div>
    </div>
    <!-- /.row -->

    <hr>

    <!-- Pagination -->
    <div class="row text-center">
        <div class="col-lg-12">
            <ul class="pagination">
                <li>
                    <a href="#">&laquo;</a>
                </li>
                <li class="active">
                    <a href="#">1</a>
                </li>
                <li>
                    <a href="#">2</a>
                </li>
                <li>
                    <a href="#">3</a>
                </li>
                <li>
                    <a href="#">4</a>
                </li>
                <li>
                    <a href="#">5</a>
                </li>
                <li>
                    <a href="#">&raquo;</a>
                </li>
            </ul>
        </div>
    </div>
    <!-- /.row -->

    <hr>

    <!-- Footer -->
    <footer>
        <div class="row">
            <div class="col-lg-12">
                <p>Copyright &copy; Web Gallery 2014</p>
            </div>
        </div>
        <!-- /.row -->
    </footer>

</div>
<!-- /.container -->

</body>

</html>