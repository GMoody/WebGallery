<%--
  Created by IntelliJ IDEA.
  User: r3dz
  Date: 12.12.2015
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="main.*" %>
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
    <title>Web Gallery - Profile info</title>

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

            <a class="navbar-brand" href="profile.jsp">Profile</a>
        </div>
        <!-- Mobile display menu END-->

        <!-- Navbar + login modal -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <!-- Navbar -->
            <ul class="nav navbar-nav">
                <li><a href="index.jsp">Main</a></li>
                <li><a href="#">Services</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
            <!-- Navbar END -->

            <!-- Profile -->
            <ul class="nav navbar-right top-nav">

                <!-- Logged-in -->
                <li class="dropdown disp_none">
                    <% try{
                        if (session.getAttribute("user_name") != null & Integer.parseInt(session.getAttribute("position").toString()) == 2) {%>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%= session.getAttribute("user_name")%><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="profile.jsp"><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Profile</a></li>
                        <li><a href="gallery.jsp"><span class="glyphicon glyphicon-picture" aria-hidden="true"></span> Gallery</a></li>
                        <li><a href="admin_panel.jsp"><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Admin panel</a></li>
                        <li class="divider"></li>
                        <li><a href="functions/logout.jsp" name="logout_btn"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Log Out</a></li>
                    </ul>
                </li>
                <!-- Logged-in end-->

                <!-- NOT Logged-in -->
                <% } else { session.invalidate(); %>
                <script> document.location.href="index.jsp"; alert("Only administration could access this page!"); </script>
                <% } }catch (Exception e){e.printStackTrace();}%>
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
<br>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="panel panel-primary"  style="border-color: #080808; margin-left: -235px; width: 180%; ">
                <div class="panel-heading" style="background-color: #323232; border-color: #080808">
                    <h3 class="panel-title">Administrator menu</h3>
                    <span class="pull-right">
                        <!-- Tabs -->
                        <ul class="nav panel-tabs">
                            <li class="active"><a href="#tab1" data-toggle="tab"><i class="glyphicon glyphicon-user"></i> Users </a></li>
                            <li><a href="#tab2" data-toggle="tab"><i class="glyphicon glyphicon-picture"></i> Images </a></li>
                            <li><a href="#tab3" data-toggle="tab"><i class="glyphicon glyphicon-eye-open"></i> Administrators </a></li>

                        </ul>
                    </span>
                </div>
                <div class="panel-body">
                    <div class="tab-content">


                        <div class="tab-pane active" id="tab1">

                            <h5 style="margin-left: 17px;"><span class="glyphicon glyphicon-align-justify" aria-hidden="true"></span> &nbsp; <b>Total users: <%
                                int users=0;
                                for (int i=0;i<User.users.size();i++){if(User.users.get(i).getId_position() == 1){users++;}}
                                out.println(users);
                            %></b></h5>
                            <div class="container" style="margin-top: -15px;">
                                <div class="row col-md-6 col-md-offset-2 custyle">
                                    <table class="table table-striped custab" style="width: 915px; margin-left: -205px;">
                                        <thead>
                                        <tr>
                                            <th>Username</th>
                                            <th>Status</th>
                                            <th>Fristname</th>
                                            <th>Lastname</th>
                                            <th>E-mail</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                        </thead>
                                        <%
                                            for (int i=0;i< User.users.size();i++){
                                                if(User.users.get(i).getId_position()==1){
                                        %>
                                        <tr>
                                            <td><%=User.users.get(i).getUser_name().toString()%></td>
                                            <td><%=Position.getPositionInfo(User.users.get(i).getId_position()).getPosition() %></td>
                                            <td><%=User.users.get(i).getFirst_name().toString()%></td>
                                            <td><%=User.users.get(i).getLast_name().toString()%></td>
                                            <td><%=User.users.get(i).getEmail().toString()%></td>
                                            <td class="text-center">
                                                <form action="functions/delete_user.jsp" method="post" style="float:right">
                                                    <input type="hidden" name="delete_user_id" value="<%=User.users.get(i).getId_user()%>">
                                                    <input type="submit" class="btn btn-danger btn-xs" value="Delete">
                                                </form>

                                                <a href='#edit_modal'  class='btn btn-primary btn-xs' data-toggle='modal' data-user_fname='<%=User.users.get(i).getFirst_name().toString()%>' data-user_lname='<%=User.users.get(i).getLast_name().toString()%>' data-user_email='<%=User.users.get(i).getEmail().toString()%>' data-user_login='<%=User.users.get(i).getUser_name().toString()%>' >Edit profile</a>

                                            </td>
                                        </tr>
                                        <%}}%>


                                    </table>
                                </div>
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
                                             <form class="form-horizontal zero-top" action='functions/edit_user_data.jsp' enctype="multipart/form-data" role="form" method="post" name="edit_form" autocomplete="off">

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">First name:</label>
                                                    <div class="col-sm-6">
                                                        <input type="text" class="form-control" name="fname"
                                                               title="Fristname should contain from 3 to 50 characters"
                                                               pattern="[A-Za-z]{3,50}"
                                                               required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">Last name:</label>
                                                    <div class="col-sm-6">
                                                        <input type="text" class="form-control" name="lname"
                                                               title="Lastname should contain from 3 to 50 characters"
                                                               pattern="[A-Za-z]{3,50}"

                                                               required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">Email:</label>
                                                    <div class="col-sm-6">
                                                        <input type="email" class="form-control" name="email"
                                                               title="Email must be in the following order: characters@characters.domain"
                                                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"

                                                               required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">Old password:</label>
                                                    <div class="col-sm-6">
                                                        <input type="password" class="form-control" name="pass0"
                                                               title="Password should contains from 6 to 20 symbols"
                                                               pattern=".{6,20}"
                                                               placeholder="Enter to make changes"
                                                               required>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">New password:</label>
                                                    <div class="col-sm-6">
                                                        <input type="password" class="form-control" name="pass1"
                                                               title="Password should contains from 6 to 20 symbols"
                                                               pattern=".{6,20}"
                                                               placeholder="Enter, if you need to change it">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">Confirm password:</label>
                                                    <div class="col-sm-6">
                                                        <input type="password" class="form-control" name="pass2"
                                                               title="Password should contains from 6 to 20 symbols"
                                                               pattern=".{6,20}"
                                                               placeholder="Confirm your new password">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="control-label col-sm-4">Avatar:</label>
                                                    <div class="col-sm-6">
                                                        <input type="file" class="form-control"
                                                               name="avatar"
                                                               id="avatar"
                                                               accept="image/jpeg,image/png"
                                                               title="You may upload only picture with size < 10mb.">
                                                    </div>
                                                </div>

                                                 <input type="hidden" name="user_login" value="">
                                                 <input type="hidden" name="is_admin" value="true">

                                                <hr style="border-color: black;">
                                                <div class="form-group">
                                                    <div class="col-sm-offset-5">
                                                        <%--<button type="submit" class="btn btn-success" name="edit_btn" id="edit_btn">Save</button>--%>
                                                        <input type="submit" class="btn btn-success" name="edit_btn" id="edit_btn" value="Save">
                                                    </div>
                                                </div>
                                            </form>


                                            <script>
                                                // Скрипт проверяет размер загружаемой аватарки.
                                                $('#edit_btn').click( function(e) {
                                                    var fsize = $('#avatar')[0].files[0].size;
                                                    if(fsize>10485760){
                                                        alert("Avatar size is more than 10 mb!");
                                                        e.preventDefault(); // Предотвращает отправление формы, если размер аватарки больше 10мб
                                                    }
                                                });
                                            </script>

                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- EditModal END -->

                            <script>
                                // The script inserts the data into a modal window
                                $('#edit_modal').on('show.bs.modal', function (e) {
                                    var user_fname = $(e.relatedTarget).data('user_fname');
                                    var user_lname = $(e.relatedTarget).data('user_lname');
                                    var user_email = $(e.relatedTarget).data('user_email');
                                    var user_login = $(e.relatedTarget).data('user_login');
                                    $(e.currentTarget).find('input[name="fname"]').val(user_fname);
                                    $(e.currentTarget).find('input[name="lname"]').val(user_lname);
                                    $(e.currentTarget).find('input[name="email"]').val(user_email);
                                    $(e.currentTarget).find('input[name="user_login"]').val(user_login); // hidden!!!

                                });
                            </script>



                        </div>





                        <div class="tab-pane" id="tab2">
                            <h5 style="margin-left: 17px;"><span class="glyphicon glyphicon-camera" aria-hidden="true"></span><b> Total pictures:  <%out.println(Picture.pictures.size());%>   </b>   &nbsp;|&nbsp;    <span class="glyphicon glyphicon-tags" aria-hidden="true"></span> <b>Total categories: <%out.println(Category.categories.size());%> </b></h5>
                            <div class="container" style=" margin-top: -15px;">
                                <div class="row col-md-6 col-md-offset-2 custyle">
                                    <table class="table table-striped custab" style="width: 915px; margin-left: -205px;">
                                        <thead>
                                        <tr>
                                            <th>№</th>
                                            <th>ID </th>
                                            <th>Picture</th>
                                            <th>Category</th>
                                            <th>Rating</th>
                                            <th>Uploaded by</th>
                                            <th>Uploaded date</th>
                                            <th class="text-center">Action</th>
                                        </tr>
                                        </thead>
                                        <%

                                            for (int i=0;i< Picture.pictures.size();i++){


                                        %>
                                        <tr>
                                            <td><%=i+1%></td>
                                            <td><%=Picture.pictures.get(i).getId_picture()%></td>
                                            <td>
                                                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                                <b><a href=" <%=Picture.pictures.get(i).getPicture_url().toString()%>" target="_blank">View image</a></b>

                                            </td>
                                            <td><%=Category.getCategoryInfo(Picture.pictures.get(i).getId_category()).getCategory()%></td>
                                            <td><%=Picture_Statistics.getPicture_statistics(Picture.pictures.get(i).getId_picture()).getPicture_rating()%></td>
                                            <td><%=User.getUserInfo(Picture.pictures.get(i).getUpl_user_id()).getUser_name().toString()%></td>
                                            <td><%=Picture.pictures.get(i).getUpl_date().toString()%></td>
                                            <td class="text-center">
                                                <form action="functions/delete_picture.jsp" method="post" style="float:right">
                                                    <input type="hidden" name="delete_pic_id" value="<%=Picture.pictures.get(i).getId_picture()%>">
                                                    <input type="submit" class="btn btn-danger btn-xs" value="Delete">
                                                </form>

                                            </td>
                                        </tr>
                                        <%}%>


                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab3">

                            <h5 style="margin-left: 17px;"><b>Know your colleagues!&nbsp;&nbsp;</b><span class="glyphicon glyphicon-lock" aria-hidden="true"></span>  </h5>
                            <div class="container" style="margin-top: -15px;">
                                <div class="row col-md-6 col-md-offset-2 custyle">
                                    <table class="table table-striped custab" style="width: 915px; margin-left: -205px;">
                                        <thead>
                                        <tr>
                                            <th>№</th>
                                            <th>Username</th>
                                            <th>Status</th>
                                            <th>Fristname</th>
                                            <th>Lastname</th>
                                            <th>E-mail address</th>

                                        </tr>
                                        </thead>
                                        <%
                                            int iterator=0;
                                            for (int i=0;i< User.users.size();i++){
                                                if(User.users.get(i).getId_position()==2){iterator++;
                                        %>
                                        <tr>
                                            <td><%=iterator%></td>
                                            <td><%=User.users.get(i).getUser_name().toString()%></td>
                                            <td><%=Position.getPositionInfo(User.users.get(i).getId_position()).getPosition() %></td>
                                            <td><%=User.users.get(i).getFirst_name().toString()%></td>
                                            <td><%=User.users.get(i).getLast_name().toString()%></td>
                                            <td><%=User.users.get(i).getEmail().toString()%></td>
                                        </tr>
                                        <%}}%>


                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!---- Page content end ----->



</body>

</html>
