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
    <%--&lt;%&ndash;<div class="row">&ndash;%&gt;--%>
        <%--&lt;%&ndash;<div class="col-lg-12">&ndash;%&gt;--%>
            <%--&lt;%&ndash;<h1 class="page-header">Account details&ndash;%&gt;--%>
                <%--&lt;%&ndash;<small></small>&ndash;%&gt;--%>
            <%--&lt;%&ndash;</h1>&ndash;%&gt;--%>
        <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
    <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
    <%--<!-- /.row -->--%>


    <br>

    <div class="container-fluid well span6">
        <div class="row-fluid">
            <div class="span2" style="float:left;">
                <img style="width:150px; height: 150px;" src="http://www.marketingextremist.com/wp-content/uploads/2014/05/How-to-Change-a-Username-in-WordPress.jpg" class="img-circle">
                <h4 style="margin-left: 35px;"><%=session.getAttribute("user_name")%></h4> <%--Отступ работает у всех по-разному--%>
            </div>

            <div class="span8" style="float:left; margin-left: 40px;">
                <h5>First name: <% out.print(User.getUserInfo(session.getAttribute("email").toString()).getFirst_name()); %></h5>
                <h5>Last name: <% out.print(User.getUserInfo(session.getAttribute("email").toString()).getLast_name()); %></h5>
                <h5>Email: <% out.print(User.getUserInfo(session.getAttribute("email").toString()).getEmail()); %></h5>
            </div>


            <div class="span2" style="float:right;">
                <td class="tg-baqh" colspan="2">
                    <a href='#edit_modal' class='btn btn-primary' data-toggle='modal'>Edit profile</a>
                </td>
            </div>


            <!-- EditModal -->
            <div id="edit_modal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header" align="center">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Personal information</h4>
                        </div>

                        <div class="modal-body">
                            <form class="form-horizontal zero-top" action='' role="form" method="post" name="edit_form" autocomplete="off">

                                <div class="form-group">
                                    <label class="control-label col-sm-4">First name:</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="fname"
                                               title="Fristname should contain from 3 to 50 characters"
                                               pattern="[A-Za-z]{3,50}"
                                               value="<% out.print(User.getUserInfo(session.getAttribute("email").toString()).getFirst_name()); %>"
                                               required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-4">Last name:</label>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control" name="lname"
                                               title="Lastname should contain from 3 to 50 characters"
                                               pattern="[A-Za-z]{3,50}"
                                               value="<% out.print(User.getUserInfo(session.getAttribute("email").toString()).getLast_name()); %>"
                                               required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-4">Email:</label>
                                    <div class="col-sm-6">
                                        <input type="email" class="form-control" name="email"
                                               title="Email must be in the following order: characters@characters.domain"
                                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
                                               value="<% out.print(User.getUserInfo(session.getAttribute("email").toString()).getEmail()); %>"
                                               required>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="control-label col-sm-4">New password:</label>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control" name="pass1"
                                               title="Password should contains from 6 to 20 symbols"
                                               pattern=".{6,20}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-4">Confirm password:</label>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control" name="pass2"
                                               title="Password should contains from 6 to 20 symbols"
                                               pattern=".{6,20}">
                                    </div>
                                </div>

                                <div class="checkbox" align="center">
                                    <label>
                                        <input  value= "YES" name="keepoldpass" type="checkbox" id="terms" data-error="Before you wreck yourself">
                                        Keep old password?
                                    </label>
                                </div>

                                <h6 style="color:red; font-style:italic; text-align: center;">If you would like to keep old password, select the box above and left password fields empty!</h6>

                                <hr style="border-color: black;">
                                <div class="form-group">
                                    <div class="col-sm-offset-5">
                                        <button type="submit" class="btn btn-success" name="edit_btn">Save</button>
                                    </div>
                                </div>
                            </form>

                            <%
                                if (request.getParameter("edit_btn") != null) {
                                    request.getRequestDispatcher("/functions/edit_user_data.jsp").include(request, response);
                                    %><script>window.location = window.location.href;</script><%
                            }
                            %>
                        </div>
                    </div>

                </div>
            </div>

            <form class="form-horizontal" action='' method="POST">
            <div class="span3" style="float:right; margin-right: -101px;margin-top: 45px;">
                <td class="tg-baqh" colspan="2"><input type="submit" class="btn btn-primary" value="View gallery"></td>
            </div>
            </form>

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