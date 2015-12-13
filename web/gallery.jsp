<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="functions.URLHandler" %>
<%@ page import="main.Category" %>
<%@ page import="main.Picture" %>
<%@ page import="main.Picture_Statistics" %>
<%@ page import="java.util.List" %>

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

            <a class="navbar-brand">Gallery</a>
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
                            <%if(Integer.parseInt(session.getAttribute("position").toString()) == 2){ %>
                                <li><a href="admin_panel.jsp"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
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

    <%
        boolean same_user = false;
        String user_name = request.getParameter("user");

        if(session.getAttribute("user_name") != null)
            if (user_name.equals(session.getAttribute("user_name").toString()))
                same_user = true;

        // Получаем необходимый лист с картинками, в зависимости от сортировки.
        request.getRequestDispatcher("/functions/make_gallery_list.jsp").include(request, response);
        List<Picture> pictures = (List<Picture>) request.getAttribute("list");
        String url = request.getRequestURL().toString() + "?" + request.getQueryString();
    %>
    <!-- Navigation tabs -->
    <ul class="nav nav-tabs">
        <% if (pictures.size() != 0){%>
            <li class="active"><a data-toggle="tab" href="#gallery"><b><%=user_name%></b> gallery</a></li>
        <%  if(same_user){ %>
                <li><a data-toggle="tab" href="#upload">Picture upload</a></li>
        <%}}else{%>
            <li class="active"><a data-toggle="tab" href="#upload">Picture upload</a></li>
        <%}%>
    </ul>
    <!-- Navigation tabs END -->

    <!-- Navigation tabs content -->
    <div class="tab-content">

        <!-- User gallery -->
        <% if(pictures.size() > 0){%>
        <div id="gallery" class="tab-pane fade in active">
        <%}else{%>
        <div id="gallery" class="tab-pane fade in"> <%}%>
            <div class="row">
                <div class="col-lg-12">
                    <div class="well well-sm">
                        <div class="btn-group">
                            <!-- Date sorting -->
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Date <span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="<%=URLHandler.makeURL(url, "date", true)%>"><span class="glyphicon glyphicon-sort-by-attributes" aria-hidden="true"></span> Ascending</a></li>
                                    <li><a href="<%=URLHandler.makeURL(url, "date", false)%>"><span class="glyphicon glyphicon-sort-by-attributes-alt" aria-hidden="true"></span> Descending</a></li>
                                </ul>
                            </div>
                            <!-- Date sorting END -->

                            <!-- Downloads sorting -->
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Downloads <span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="<%=URLHandler.makeURL(url, "downloads", true)%>"><span class="glyphicon glyphicon-sort-by-attributes" aria-hidden="true"></span> Ascending</a></li>
                                    <li><a href="<%=URLHandler.makeURL(url, "downloads", false)%>"><span class="glyphicon glyphicon-sort-by-attributes-alt" aria-hidden="true"></span> Descending</a></li>
                                </ul>
                            </div>
                            <!-- Downloads sorting END -->

                            <!-- Rating sorting -->
                            <div class="btn-group">
                                <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Rating <span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="<%=URLHandler.makeURL(url, "rating", true)%>"><span class="glyphicon glyphicon-sort-by-attributes" aria-hidden="true"></span> Ascending</a></li>
                                    <li><a href="<%=URLHandler.makeURL(url, "rating", false)%>"><span class="glyphicon glyphicon-sort-by-attributes-alt" aria-hidden="true"></span> Descending</a></li>
                                </ul>
                            </div>
                            <!-- Rating sorting END -->

                        </div>
                    </div>
                </div>
            </div>

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

                if(pictures.size() < 12){
                    i = 0;
                    y = pictures.size();
                }

                for (int z = i; z < y; z++){ %>
                    <div class="col-md-3 portfolio-item">
                        <a href="picture.jsp?picture=<%=pictures.get(z).getId_picture()%>"><img class="img-responsive" src="<%=pictures.get(z).getPicture_url()%>" alt="<%=pictures.get(z).getDescription() %>"></a>
                        <div class="toolbox well">
                            <p><span class="glyphicon glyphicon-download-alt"></span> <%=Picture_Statistics.getPicture_statistics(pictures.get(z).getId_picture()).getTotal_downloads()%></p>
                            <p><span class="glyphicon glyphicon-time"></span> <%=pictures.get(z).getUpl_date()%></p>
                            <p><span class="glyphicon glyphicon-star"></span> <%=Picture_Statistics.getPicture_statistics(pictures.get(z).getId_picture()).getPicture_rating()%></p>
                        </div>
                    </div>
                <%}%>
            </div>
            <!-- Pictures -->

            <!-- Pagination Row -->
            <div class="row text-center">
                <div class="col-lg-12">
                    <ul class="pagination"><%
                        // Стрелочка влево выводится всегда, кроме как на 1-ой странице.
                            if(current_page!=1){
                                %><li><a href="<%=URLHandler.makeGalleryPage(url,current_page-1)%>">&laquo;</a></li><%
                            }

                            // Имеем ли все страницы полностью заполненные по 12 картинок
                            if(pictures.size() % 12 != 0){
                                for (int w = 1; w < (pictures.size() / 12) + 2; w++){
                                    if(w==current_page){ // Выделяет цифру странички, если ты на ней находишься.
                                        %><li class="active"><a href="<%=URLHandler.makeGalleryPage(url,w)%>"><%=w%></a></li><%
                                    }else{
                                        %><li><a href="<%=URLHandler.makeGalleryPage(url,w)%>"><%=w%></a></li><%
                                    }
                                }

                                if((pictures.size()/12) + 1 > current_page){ // Стрелочка вправо выводится всегда, кроме как на последней странице.
                                    %><li><a href="<%=URLHandler.makeGalleryPage(url,current_page+1)%>">&raquo;</a></li><%
                                }

                            }else{ // Имеем все страницы по 12 картинок!
                                for (int w = 1; w < (pictures.size() / 12) + 1; w++){
                                    if(w==current_page){ // Выделяет цифру странички, если ты на ней находишься.
                                        %><li class="active"><a href="<%=URLHandler.makeGalleryPage(url,w)%>"><%=w%></a></li><%
                                    }else{
                                        %><li><a href="<%=URLHandler.makeGalleryPage(url,w)%>"><%=w%></a></li><%
                                    }
                                }

                                if(current_page!= pictures.size() / 12){ // Стрелочка вправо выводится всегда, кроме как на последней странице.
                                %><li><a href="<%=URLHandler.makeGalleryPage(url,current_page+1)%>">&raquo;</a></li><%
                                }
                            }%>
                    </ul>
                </div>
            </div>
            <!-- Pagination Row END -->
        </div>
        <!-- User gallery END -->

        <!-- Picture upload -->
        <% if(pictures.size() > 0){%>
        <div id="upload" class="tab-pane fade in">
        <%}else{%>
        <div id="upload" class="tab-pane fade in active"> <%}%>

                <h3>Picture upload</h3>
                <div class="well well">
                    <form class="form-horizontal zero-top" action='functions/upload_picture.jsp' enctype="multipart/form-data" role="form" method="post" name="picture_form" autocomplete="off">
                        <!-- Category select -->
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="category">Category:</label>
                            <div class="col-sm-4">
                                <select class="form-control" id="category" name="category">
                                    <%
                                        List<Category> categories = Category.sortCategories();
                                        for (Category category : categories)
                                            if (category.getCategory().equals("Other"))
                                                out.println("<option value='"+category.getCategory()+"' selected>" + category.getCategory() + "</option>");
                                            else
                                                out.println("<option value='"+category.getCategory()+"'>" + category.getCategory() + "</option>");
                                    %>
                                </select>
                            </div>
                        </div>
                        <!-- Category select END -->

                        <!-- Description -->
                        <div class="form-group">
                            <label class="control-label col-sm-4">Description:</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="description"
                                       title="Description should be from 5 to 150 characters"
                                       placeholder="Picture description (not necessarily)">
                            </div>
                        </div>
                        <!-- Description END -->

                        <!-- Picture -->
                        <div class="form-group">
                            <label class="control-label col-sm-4">Picture:</label>
                            <div class="col-sm-4">
                                <span class="btn btn-default btn-file btn-block">Browse
                                    <input type="file"
                                       name="picture"
                                       id="picture"
                                       accept="image/jpeg,image/png"
                                       title="You may upload only picture with size < 10mb."
                                       required>
                                </span>
                            </div>
                        </div>
                        <!-- Picture END -->

                        <div class="form-group">
                            <div class="col-sm-3" style="margin-left: 420px;">
                                <button type="submit" class="btn btn-success btn-block" name="upload_btn" id="upload_btn">Upload</button>
                            </div>
                        </div>
                    </form>

                    <script>
                        // Скрипт проверяет размер загружаемой аватарки.
                        $('#upload_btn').click( function(e) {
                            var fsize = $('#picture')[0].files[0].size;
                            if(fsize>10485760){
                                alert("Picture size is more than 10 mb!");
                                e.preventDefault(); // Предотвращает отправление формы, если размер картинки больше 10мб
                            }
                        });
                    </script>
                </div>
        </div>
        <!-- Picture upload END -->

    </div>
    <!-- Navigation tabs content END -->

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