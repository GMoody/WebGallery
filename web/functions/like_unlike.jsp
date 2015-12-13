<%@ page import="main.*" %>

<%
    int user_id = 0, picture_id = 0;
    boolean addlike = false, deletelike = false;
    String action = "";

    try {
        action = request.getParameter("action");

        if (action.equals("like")){

            user_id = Integer.parseInt(request.getParameter("like_commentator"));
            picture_id = Integer.parseInt(request.getParameter("like_picture_id"));

            if(user_id != 0 && picture_id != 0)
                addlike = Picture.likePicture(user_id, picture_id);
            else
                out.println("user_id or picture id is 0");


            if(addlike){
                %><script> alert("Liked, thanks!");
                window.location = document.referrer; </script><%
            }else{
                %><script> alert("Unliked, like wisely!");
                window.location = document.referrer; </script><%
            }


        }else if (action.equals("dislike")) {
            user_id = Integer.parseInt(request.getParameter("unlike_commentator"));
            picture_id = Integer.parseInt(request.getParameter("unlike_picture_id"));

            if (user_id != 0 & picture_id != 0)
                deletelike = Picture.unlikePicture(user_id, picture_id);
            else
                out.println("user_id or picture id is 0");

            if (deletelike) {
                %><script> alert("Picture is unliked!");
                window.location = document.referrer; </script><%
            }else{
                %><script> alert("Picture was not disliked!");
                window.location = document.referrer; </script><%
            }

        }else{
            out.println("Error, action is not like/dislike it is:");
            out.println(action);
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println(action);
        out.println(user_id);
        out.println("General Exception look at parameters or sql statement!");
        out.println(picture_id);
    }
%>
