<%@ page import="main.Picture" %>
<%@ page import="java.util.List" %>
<%@ page import="main.Picture_Statistics" %>
<%@ page import="functions.URLHandler" %>

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
                <% if (session.getAttribute("user_name") == null){%>
                    <li><a href="register.jsp">Registration</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Contact</a></li>
                <% }else{ %>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Contact</a></li>
                <% } %>
            </ul>
            <!-- Navbar END -->

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">

                <!-- Logged-in -->
                <li class="dropdown disp_none">
                    <% if (session.getAttribute("user_name") != null) {%>
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

                <!-- NOT Logged-in -->
                <% } else {%>
                <li class="dropdown disp_none">
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
            <div class="well well-sm">
                <div class="btn-group">
                    <%
                        // Получаем необходимый лист с картинками, в зависимости от сортировки.
                        request.getRequestDispatcher("/functions/make_list.jsp").include(request, response);
                        List<Picture> pictures = (List<Picture>) request.getAttribute("list");
                        String url;

                        // Необходимая обработка URL
                        if(request.getRequestURL().toString().contains("index.jsp"))
                            if(request.getQueryString() != null) url = request.getRequestURL().toString() + "?" + request.getQueryString();
                            else url = request.getRequestURL().toString() + "?page=1";
                        else url = request.getRequestURL() + "index.jsp?";

                    %>
                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Date <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="<%=URLHandler.makeURL(url, "date", true)%>"><span class="glyphicon glyphicon-sort-by-attributes" aria-hidden="true"></span> Ascending</a></li>
                            <li><a href="<%=URLHandler.makeURL(url, "date", false)%>"><span class="glyphicon glyphicon-sort-by-attributes-alt" aria-hidden="true"></span> Descending</a></li>
                        </ul>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Downloads <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="<%=URLHandler.makeURL(url, "downloads", true)%>"><span class="glyphicon glyphicon-sort-by-attributes" aria-hidden="true"></span> Ascending</a></li>
                            <li><a href="<%=URLHandler.makeURL(url, "downloads", false)%>"><span class="glyphicon glyphicon-sort-by-attributes-alt" aria-hidden="true"></span> Descending</a></li>
                        </ul>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Rating <span class="caret"></span></button>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="<%=URLHandler.makeURL(url, "rating", true)%>"><span class="glyphicon glyphicon-sort-by-attributes" aria-hidden="true"></span> Ascending</a></li>
                            <li><a href="<%=URLHandler.makeURL(url, "rating", false)%>"><span class="glyphicon glyphicon-sort-by-attributes-alt" aria-hidden="true"></span> Descending</a></li>
                        </ul>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <!-- /.row -->

    <!-- Pictures -->
    <div class="row"><%

        int i = 0, y = 12, current_page = 1; // Переменные для работы с выводом картинок.

        if(request.getParameter("page") != null){
            current_page = Integer.parseInt(request.getParameter("page")); // Страница на которой находимся.
            int full_pages = pictures.size() / 12;                         // Число страниц, которые заполняются полностью по 12 картинок.

            if(current_page > full_pages){ // Если мы находимся на страничке, которая заполняется не полностью, не 12 картинками.
                i = pictures.size() - (current_page * full_pages);
                y = i + (current_page * full_pages);
            }else{
                y = y * current_page;
                i = y-12;
            }
        }

        if (pictures.size() != 0){
            for (int z = i; z < y; z++){ %>
                <div class="col-md-3 portfolio-item">
                    <a href="picture.jsp?picture=<%=pictures.get(z).getId_picture()%>"><img class="img-responsive" src="<%=pictures.get(z).getPicture_url()%>" alt="<%=pictures.get(z).getDescription() %>"></a>
                        <div class="toolbox well">
                            <p><span class="glyphicon glyphicon-download-alt"></span> <%=Picture_Statistics.getPicture_statistics(pictures.get(z).getId_picture()).getTotal_downloads()%></p>
                            <p><span class="glyphicon glyphicon-time"></span> <%=pictures.get(z).getUpl_date()%></p>
                            <p><span class="glyphicon glyphicon-star"></span> <%=Picture_Statistics.getPicture_statistics(pictures.get(z).getId_picture()).getPicture_rating()%></p>
                        </div>
                </div>
            <%}
        }%>
    </div>
    <!-- Pictures -->

    <!-- Pagination Row -->
    <div class="row text-center">
        <div class="col-lg-12">
            <ul class="pagination">

                <%
                    // Стрелочка влево выводится всегда, кроме как на 1-ой странице.
                    if(current_page!=1){
                        %><li><a href="<%=URLHandler.makePage(url,current_page-1)%>">&laquo;</a></li><%
                    }

                    // Имеем ли все страницы полностью заполненные по 12 картинок
                    if(pictures.size() % 12 != 0){
                        for (int w = 1; w < (pictures.size() / 12) + 2; w++){
                            if(w==current_page){ // Выделяет цифру странички, если ты на ней находишься.
                                %><li class="active"><a href="<%=URLHandler.makePage(url,w)%>"><%=w%></a></li><%
                            }
                            else{
                                %><li><a href="<%=URLHandler.makePage(url,w)%>"><%=w%></a></li><%
                            }
                        }

                        if((pictures.size()/12) + 1 > current_page){ // Стрелочка вправо выводится всегда, кроме как на последней странице.
                            %><li><a href="<%=URLHandler.makePage(url,current_page+1)%>">&raquo;</a></li><%
                        }

                    }else{ // Имеем все страницы по 12 картинок!
                        for (int w = 1; w < (pictures.size() / 12) + 1; w++){
                            if(w==current_page){ // Выделяет цифру странички, если ты на ней находишься.
                                %><li class="active"><a href="<%=URLHandler.makePage(url,w)%>"><%=w%></a></li><%
                            }else{
                                %><li><a href="<%=URLHandler.makePage(url,w)%>"><%=w%></a></li><%
                            }
                        }

                        if(current_page!= pictures.size() / 12){ // Стрелочка вправо выводится всегда, кроме как на последней странице.
                            %><li><a href="<%=URLHandler.makePage(url,current_page+1)%>">&raquo;</a></li><%
                        }
                    }
                %>

            </ul>
        </div>
    </div>
    <!-- Pagination Row END -->

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