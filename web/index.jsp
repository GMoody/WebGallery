<!DOCTYPE html>
<html lang="en">
    
    <head>
        
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Web Gallery</title>
        
        <!-- JS -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.js"></script>

        <!-- CSS -->
        <link href="css/simple-sidebar.css" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
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
                        <li><a href="#">About</a></li>
                        <li><a href="#">Services</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>
        
        <div id="wrapper">
            
        <!-- Sidebar -->
            <div id="sidebar-wrapper">
                <ul class="sidebar-nav">
                    <li class="sidebar-brand">
                        <a href="#">Web Gallery</a>
                    </li>
                    <li><a href="#">Dashboard</a></li>
                    <li><a href="#">Shortcuts</a></li>
                    <li><a href="#">Overview</a></li>
                    <li><a href="#">Events</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
            <%--griwa i  vadja--%>
        <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-lg-12">
                            <a href="#menu-toggle" class="btn btn-default" id="menu-toggle">Toggle Menu</a>
                        </div>
                    </div>
                </div>
                
                <!-- Projects Row -->
                <div class="row">
                    <div class="col-md-6 portfolio-item">
                        <a href="#"><img class="img-responsive" src="http://placehold.it/700x400" alt=""></a>
                        <h3><a href="#">Project One</a></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                    
                    <div class="col-md-6 portfolio-item">
                        <a href="#"><img class="img-responsive" src="http://placehold.it/700x400" alt=""></a>
                        <h3><a href="#">Project Two</a></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                </div>
                <!-- /.row -->
            
                <!-- Projects Row -->
                <div class="row">
                    <div class="col-md-6 portfolio-item">
                        <a href="#"><img class="img-responsive" src="http://placehold.it/700x400" alt=""></a>
                        <h3><a href="#">Project Three</a></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                    
                    <div class="col-md-6 portfolio-item">
                        <a href="#"><img class="img-responsive" src="http://placehold.it/700x400" alt=""></a>
                        <h3><a href="#">Project Four</a></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                </div>
                <!-- /.row -->
                
                <!-- Projects Row -->
                <div class="row">
                    <div class="col-md-6 portfolio-item">
                        <a href="#"><img class="img-responsive" src="http://placehold.it/700x400" alt=""></a>
                        <h3><a href="#">Project Five</a></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                    
                    <div class="col-md-6 portfolio-item">
                        <a href="#"><img class="img-responsive" src="http://placehold.it/700x400" alt=""></a>
                        <h3><a href="#">Project Six</a></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                </div>
                <!-- /.row -->
                
                <hr>
                
                <!-- Pagination -->
                <div class="row text-center">
                    <div class="col-lg-12">
                        <ul class="pagination">
                            <li><a href="#">&laquo;</a> </li>
                            <li class="active"><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
                <!-- /.row -->
                
                <hr>
                
                <!-- Footer -->
                <footer>
                    <div class="row">
                        <div class="col-lg-12">
                            <p>Copyright &copy; Your Website 2014</p>
                        </div>
                    </div>
                    <!-- /.row -->
                </footer>
                
            </div>
            <!-- /#page-content-wrapper -->

        </div>
    <!-- /#wrapper -->

        <!-- Menu Toggle Script -->
        <script>
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#wrapper").toggleClass("toggled");
        });
        
        </script>
        
    </body>
</html>
