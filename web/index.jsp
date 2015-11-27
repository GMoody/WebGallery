<%@ page import="main.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="functions.PictureHandler" %>

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
                <% if (session.getAttribute("user_name") == null){%>
                    <li><a href="register.jsp">Registration</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Contact</a></li>
                    <% }else{ %>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Contact</a></li>
                <% } %>
            </ul>

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">
                <!-- Logged-in -->
                <li class="dropdown">
                    <% if (session.getAttribute("user_name") != null) {%>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("user_name")%><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                        <% if(Integer.valueOf(session.getAttribute("position").toString())  == 3){ %>
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

    <%
        // y = 12, т.к. на странице может быть до 12 изображений ( 3 ряда * 4 изображения в ряду)
        List<Picture> pictures = null;
        int current_page = 1, i = 0, y = 12;

        if(request.getParameter("page") != null){
            current_page = Integer.parseInt(request.getParameter("page"));
            i += 12;
            y = i;
        }

        try{
            // Берём лист из метода getMainPictures(), т.к. этот метод выкачивает только новые изображения, при необходимости.
            pictures = PictureHandler.getMainPictures();

            for (int x = i; i < y; x++){
                // if- ы нужны для правильного отображения страница: либо указываем новый ряд с картинкой, либо картинку и закрывающий тэг ряда, либо просто картинку.
                if(x%4==0){
                    %><div class="row">
                         <div class="col-md-3 portfolio-item">
                            <a href="picture.jsp?picture= <% pictures.get(x).getId_picture(); %>"><img class="img-responsive" width="750" height="450" src="<% pictures.get(x).getPicture_url(); %>" alt="<% pictures.get(x).getDescription(); %>"></a>
                         </div><%
                }
                else {
                    if(x+1%4==0){
                        %><div class="col-md-3 portfolio-item">
                             <a href="picture.jsp?picture= <% pictures.get(x).getId_picture(); %>"><img class="img-responsive" width="750" height="450" src="<% pictures.get(x).getPicture_url(); %>" alt="<% pictures.get(x).getDescription(); %>"></a>
                          </div></div><%
                    }
                    else {
                        %><div class="col-md-3 portfolio-item">
                            <a href="picture.jsp?picture= <% pictures.get(x).getId_picture(); %>"><img class="img-responsive" width="750" height="450" src="<% pictures.get(x).getPicture_url(); %>" alt="<% pictures.get(x).getDescription(); %>"></a>
                        </div><%
                    }
                }

            }


        }catch (Exception ex){
            System.out.println("Index.jsp Error: " + ex.getMessage());
            ex.printStackTrace();
        }

    %>

    <hr>

    <!-- Pagination -->
    <%
        // Узнаём кол-во страниц, основыаясь на размере листа с картинками.
        int pages = pictures.size() % 12;

        switch (pages){

            case 0:
                // No pagination at all
                break;
            case 1:
                // No prev. / next arrows
                %>
                    <div class="row text-center">
                        <div class="col-lg-12">
                            <ul class="pagination">
                                <li class="active">
                                    <a href="#">1</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                <%
                break;
            default:
                // Got everything

                %>
                    <div class="row text-center">
                        <div class="col-lg-12">
                            <ul class="pagination">
                                <li>
                                    <a href="index.jsp?page=<%=current_page-1%>">&laquo;</a>
                                </li>

                                <%  // В цикле выводится необходимое кол-во страниц.
                                    for(int z = 0; z < pages+1; z++){
                                        if(i == current_page){ %>
                                            <li class="active">
                                                <a href="index.jsp?page=<%=current_page%>"><%=current_page%></a>
                                            </li><%
                                        }
                                        else{ %>
                                            <a href="index.jsp?page=<%=z+1%>"><%=z+1%></a><%
                                        }
                                    }
                                %>

                                <li>
                                    <a href="index.jsp?page=<%=current_page+1%>">&raquo;</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                <%
                break;
        }

    %>
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