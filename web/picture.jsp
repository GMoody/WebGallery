<%@ page import="main.Picture" %>
<%@ page import="main.User" %>
<%@ page import="main.Picture_Statistics" %>
<%@ page import="main.Category" %>

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
    <%  Integer picture_id = Integer.parseInt(request.getParameter("picture"));
        String url = Picture.getPictureInfo(picture_id).getPicture_url().toString();
        Picture.addCommentToPicture(picture_id);

    %>

    <!-- Picture + Tools + Info -->
    <div class="row">

        <!-- Picture toolmenu -->
        <div class="toolmenu" style="text-align: center;">
            <!-- Picture options -->
            <b><span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> Category: </b>
            <%=Category.getCategoryInfo(Picture.getPictureInfo(picture_id).getId_category()).getCategory()%> |

            <span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>
            <b><a href="<%=Picture.getPictureInfo(picture_id).getPicture_url()%>" target="_blank">Full screen</a></b>
            <%out.println(" | ");%>

            <span class="glyphicon glyphicon-download" aria-hidden="true"></span>
            <b><a href="<%=Picture.getPictureInfo(picture_id).getPicture_url()%>" download="" target="_blank">Download</a></b>
            <!-- Picture options END -->

            <!-- Picture -->
            <div class="picture_url" style="width:50%; margin:auto; margin-top: 5px;">
                <a class="thumbnail"><img src="<%=Picture.getPictureInfo(picture_id).getPicture_url()%>" alt=""></a>
            </div>
            <!-- Picture END -->
        </div>
        <!-- Picture toolmenu END -->

        <!-- Picture description -->
        <div class="picture_description" style="margin-left:-5px; text-align:center;">
            <b>Description:</b>
            <%
                try {
                    if (Picture.getPictureInfo(picture_id).getDescription() != null | Picture.getPictureInfo(picture_id).getDescription().isEmpty())
                        out.println(Picture.getPictureInfo(picture_id).getDescription());
                }catch (Exception e){ out.println("No description was provided"); }
            %>
        </div>
        <!-- Picture description END -->

        <!-- Picture info -->
        <div class="picture_info" style="margin-left:-5px; margin-top:10px; text-align:center;">
            <i class="glyphicon glyphicon-user"></i> by <a href="#"><%=User.getUserInfo(Picture.getPictureInfo(picture_id).getUpl_user_id()).getUser_name() %></a>
            | <i class="glyphicon glyphicon-calendar"></i> <%=Picture.getPictureInfo(picture_id).getUpl_date().toString()%>
            | <i class="glyphicon glyphicon-comment"></i> <b><%=Picture.getPictureInfo(picture_id).getComments().size()%></b> Comments <!-- Make well with comments -->
            | <i class="glyphicon glyphicon-thumbs-up"></i> <b><%=Picture_Statistics.getPicture_statistics(picture_id).getTotal_voted()%></b> Likes <!-- Only shows amount of likes, but not LIKE-button -->
            | <i class="glyphicon glyphicon-download-alt"></i> <b><%=Picture_Statistics.getPicture_statistics(picture_id).getTotal_downloads()%></b> Downloads
            | <i class="glyphicon glyphicon-star"></i> <b><%=Picture_Statistics.getPicture_statistics(picture_id).getPicture_rating()%></b> Rating
        </div>
        <!-- Picture info END -->

    </div>
    <!-- Picture + Tools + Info END -->

    <!-- Comment form -->
    <div class="comment" style="margin-top: 20px;">
        <%try{%>
     <% if (session.getAttribute("user_name") != null){%>
        <form style="width: 50%; margin: 5px auto auto;" action="functions/add_comment.jsp" method="post">
            <div class="form-group">
                <label for="comment">Your Comment</label>
                <textarea id="comment" name="comment" class="form-control" rows="3"></textarea>
                <input type="hidden" name="picture_id" value="<%=picture_id%>">
                <input type="hidden" name="commentator" value="<%=User.getUserInfoByUserName((String)session.getAttribute("user_name")).getId_user()%>">
            </div>
            <input type="submit" value="Send" class="btn btn-success btn-sm">
        </form>
    </div>
    <!-- Comment form END -->
        <!------------------- COMMENTARY FORM END --------------------------->
    <%}%>
    <% if(Picture.getPictureInfo(picture_id).getComments().size()>0){%>
        <!------------------- COMMENTS AREA ------------------------------>
    <div class="container" style="width: 75%; margin-top: 25px;">
    <div class="row">
        <div class="panel panel-default widget">
            <div class="panel-heading">
                <span class="glyphicon glyphicon-comment" style="margin-left: 10px;"></span>
                <h3 class="panel-title" style="float: left;">
                    Recent Comments</h3>
                <span class="label label-info" style="margin-left: 10px;">
                   <%=Picture.getPictureInfo(picture_id).getComments().size()%> </span>
            </div>
            <div class="panel-body">
                <ul class="list-group">

                    <!----------------------------- TESTOVIY KOMMENTARIY ----------------------------->
                    <%

                        for(int i=0;i<Picture.getPictureInfo(picture_id).getComments().size();i++)
                        { %>

                        <li class="list-group-item">
                        <div class="row">

                            <div class="col-xs-10 col-md-11">
                                <div>
                                    <div class="mic-info">
                                        By: <a href="#"><%out.println(User.getUserInfo(Picture.getPictureInfo(picture_id).getComments().get(i).getId_user()).getUser_name());%></a> on <% out.println(Picture.getPictureInfo(picture_id).getComments().get(i).getAdd_date().toString());%>
                                    </div>
                                </div>
                                <div class="comment-text">
                                    <% out.println(Picture.getPictureInfo(picture_id).getComments().get(i).getComment()); %>
                                </div>
                                <div class="action">
                                    <% if(User.getUserInfoByUserName((String) session.getAttribute("user_name")).getId_user() == Picture.getPictureInfo(picture_id).getComments().get(i).getId_user() | User.getUserInfoByUserName((String) session.getAttribute("user_name")).getId_position() == 2){%>

                                        <form action="functions/delete_comment.jsp" method="post">
                                            <input type="hidden" name="c_picture_id" value="<%=picture_id%>">
                                            <input type="hidden" name="delete_id" value="<%=Picture.getPictureInfo(picture_id).getComments().get(i).getId_comment() %>">
                                           <input type="submit" class="btn btn-danger btn-xs" value="Delete">


                                        </form>

                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </li>

                    <%
                        }
                    %>


                    <!---------------------------------------------------------->
                    </ul>
                     <a href="#" class="btn btn-primary btn-sm btn-block" role="button"><span class="glyphicon glyphicon-refresh"></span> More</a>
                    </div>

                    <%--<!---------------------------------------------------------->--%>
                    <%--</ul>--%>
                     <%--<a href="#" class="btn btn-primary btn-sm btn-block" role="button"><span class="glyphicon glyphicon-refresh"></span> More</a>--%>
                    <%--</div>--%>

                    <%--<%}%>--%>

        </div>
    </div>
</div>

        <!------------------- COMMENTS AREA END------------------------------>



<%}
}catch (Exception e){e.printStackTrace();}%>


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