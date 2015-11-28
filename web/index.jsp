
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
            <h1 class="page-header">Tool menu
                <small>Secondary Text</small>
            </h1>
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
                <p>Copyright &copy; Web Gallery 2015</p>
            </div>
        </div>
        <!-- /.row -->
    </footer>

</div>
<!-- /.container -->

</body>

</html>