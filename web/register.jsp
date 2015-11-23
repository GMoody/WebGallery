<%--
  Created by IntelliJ IDEA.
  User: r3dz
  Date: 23.11.2015
  Time: 16:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Web Gallery">
    <meta name="author" content="RDIR51: G. Tureev, D. Kulakov">

    <title>Web Gallery</title>

    <!-- CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/4-col-portfolio.css" rel="stylesheet">
    <link href="css/webgallery.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

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
                <li><a href="#somewhere">Services</a></li>
                <li><a href="#somewhere">Contact</a></li>
                <% }else{ %>
                <li><a href="#somewhere">Services</a></li>
                <li><a href="#somewhere">Contact</a></li>
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
                                    //request.getRequestDispatcher("/functions/login.jsp").include(request, response);
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

    <!-- Registeration form -->

    <form class="form-horizontal" action='' method="POST">

            <div id="legend">
                <legend class="">Have an Account ?</legend>
            </div>
            <div class="control-group">
                <!-- Username -->
                <label class="control-label"  for="username">Username</label>
                <div class="controls">
                    <input type="text"  min="5" max="20" id="username" name="username" placeholder="" class="input-xlarge">
                    <p class="help-block">Username can contain any letters or numbers, without spaces 5-20 items</p>
                </div>
            </div>

            <div style="float:left;" class="control-group">
                <!-- Firstname -->
                <label class="control-label"  for="firstname">Fristname</label>
                <div class="controls">
                    <input type="text"  min="3" max="50" id="firstname" name="firstname" placeholder="" class="input-xlarge">
                    <p class="help-block">Firstname contains only letters</p>
                </div>
            </div>

            <div style="margin-left:250px;" class="control-group">
                <!-- Lastname -->
                <label class="control-label"  for="lastname">Lastname</label>
                <div class="controls">
                    <input type="text"  min="3" max="50" id="lastname" name="lastname" placeholder="" class="input-xlarge">
                    <p class="help-block">Lastname contains only letters</p>
                </div>
            </div>

            <div class="control-group">
                <!-- E-mail -->
                <label class="control-label" for="email">E-mail</label>
                <div class="controls">
                    <input type="text"  min="5" max="50" id="email" name="email" placeholder="" class="input-xlarge">
                    <p class="help-block">Please provide your E-mail</p>
                </div>
            </div>

            <div style="float:left;" class="control-group">
                <!-- Password-->
                <label class="control-label" for="password">Password</label>
                <div class="controls">
                    <input style="width: 155px;"  min="6" max="20" type="password" id="password" name="password" placeholder="" class="input-xlarge">
                    <p class="help-block">Should be at least 6 characters</p>
                </div>
            </div>

            <div style="margin-left:250px;" class="control-group">
                <!-- Password -->
                <label class="control-label"  for="password_confirm">Password (Confirm)</label>
                <div class="controls">
                    <input style="width: 155px;" min="6" max="20"  type="password" id="password_confirm" name="password_confirm" placeholder="" class="input-xlarge">
                    <p class="help-block">Please confirm password</p>
                </div>
            </div>
            <div class="checkbox">
            <label>
                <input  value= "YES" name="ishuman" type="checkbox" id="terms" data-error="Before you wreck yourself" required>
                Are you human?
            </label>
            <div class="help-block with-errors"></div>
            </div>

            <div class="control-group">
                <!-- Button -->
                <div style="margin-top: 40px;" class="controls">
                    <button type="submit" class="btn btn-success" name="submit_btn">
                    <span class="glyphicon glyphicon-ok"></span>  Register</button>

                </div>
            </div>

    </form>

    <%
        if (request.getParameter("submit_btn") != null) {
            request.getRequestDispatcher("registration.jsp").include(request, response);
        }
    %>




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