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
    <title>Web Gallery - Registration</title>

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

            <a class="navbar-brand">Registration</a>
        </div>
        <!-- Mobile display menu END-->

        <!-- Navbar + login modal -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <!-- Navbar -->
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">Main</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
            <!-- Navbar END -->

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">

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

    <!-- Registration form -->
    <form class="form-horizontal" action='' method="POST">

            <div id="legend">
                <legend class="">Have an Account ?</legend>
            </div>

            <!-- Username -->
            <div class="control-group">
                <label class="control-label" for="username">Username</label>
                <div class="controls">
                    <input type="text" pattern="[A-Za-z0-9]{5,20}" id="username" name="username" placeholder="" class="input-xlarge">
                    <p class="help-block">Username can contain letters or numbers without spaces (5-20 characters)</p>
                </div>
            </div>
            <!-- Username END-->

            <!-- Firstname -->
            <div style="float:left;" class="control-group">
                <label class="control-label"  for="firstname">Fristname</label>
                <div class="controls">
                    <input type="text"  pattern="[A-Za-z]{3,50}"  id="firstname" name="firstname" placeholder="" class="input-xlarge">
                    <p class="help-block">First name can contain only letters</p>
                </div>
            </div>
            <!-- Firstname END-->

            <!-- Lastname -->
            <div style="margin-left:250px;" class="control-group">
                <label class="control-label"  for="lastname">Lastname</label>
                <div class="controls">
                    <input type="text"  pattern="[A-Za-z]{3,50}" id="lastname" name="lastname" placeholder="" class="input-xlarge">
                    <p class="help-block">Last name can contain only letters</p>
                </div>
            </div>
            <!-- Lastname END -->

            <!-- Email -->
            <div class="control-group">
                <label class="control-label" for="email">E-mail</label>
                <div class="controls">
                    <input type="text"  title="Email must be in the following order: characters@characters.domain" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" id="email" name="email" placeholder="" class="input-xlarge">
                    <p class="help-block">Please provide your E-mail</p>
                </div>
            </div>
            <!-- Email END -->

            <!-- Password-->
            <div style="float:left;" class="control-group">
                <label class="control-label" for="password">Password</label>
                <div class="controls">
                    <input style="width: 155px;" type="password" title="Password should contains from 6 to 20 symbols" pattern=".{6,20}" id="password" name="password" placeholder="" class="input-xlarge">
                    <p class="help-block">Password should be at least 6 characters</p>
                </div>
            </div>
            <!-- Password END-->

            <!-- Password confirm -->
            <div style="margin-left:250px;" class="control-group">
                <label class="control-label"  for="password_confirm">Password (Confirm)</label>
                <div class="controls">
                    <input style="width: 155px;" title="Password should contains from 6 to 20 symbols"  pattern=".{6,20}"  type="password" id="password_confirm" name="password_confirm" placeholder="" class="input-xlarge">
                    <p class="help-block">Please confirm your password</p>
                </div>
            </div>
            <!-- Password confirm END-->

            <!-- Human check -->
            <div class="checkbox">
                <label>
                    <input  value= "YES" name="ishuman" type="checkbox" id="terms" data-error="Before you wreck yourself" required>
                    Are you human?
                </label>
                <div class="help-block with-errors"></div>
            </div>
            <!-- Human check END-->

            <!-- Register button -->
            <div class="control-group">
                <div style="margin-top: 40px;" class="controls">
                    <button type="submit" class="btn btn-success" name="submit_btn">
                    <span class="glyphicon glyphicon-ok"></span>  Register</button>
                </div>
            </div>
            <!-- Register button END -->

    </form>
    <!-- Registration form END-->

    <!-- Registration function call-->
    <%
        if (request.getParameter("submit_btn") != null) {
            request.getRequestDispatcher("functions/registration.jsp").include(request, response);
            %><script>window.location = "index.jsp";</script><%
        }
    %>
    <!-- Registration function call END-->

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