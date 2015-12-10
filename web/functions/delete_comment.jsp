
<%@ page import="main.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="functions.Connections" %>

<%
        boolean is_deleted = false; int picture_id=0; int id_comment=0;
        // получаем ИД комента для удаляения его из БД, получаем ИД картинки для удаления этого коммента из ЛИСТА КОММЕНТОВ картинки!
        try{
            id_comment = Integer.parseInt(request.getParameter("delete_id"));
            picture_id = Integer.parseInt(request.getParameter("c_picture_id"));
            is_deleted = Picture.DeleteComment(id_comment);  // запрос удаляет коммент, если тру - то коммент удален.
        }catch (Exception e){e.printStackTrace();}

        //Если ИД картнки не нулевой и ид коммента тоже не ноль, значит данные получены верно. Если коммент удален из БД, можно удалить его из листа!
        if(is_deleted & picture_id !=0 & id_comment !=0 ){
            // В цикле пройдемся по всем комментам картинки (ИД), и удалим коммент который был удален в запросе!
            for (int i = 0; i < Picture.getPictureInfo(picture_id).getComments().size(); i++){
                if(Picture.getPictureInfo(picture_id).getComments().get(i).getId_comment() == id_comment){
                    Picture.getPictureInfo(picture_id).getComments().remove(i);
                }

            }

                    // Саксесс
            %>
                <script>   alert("Your comment deleted!");
                window.location = document.referrer; </script>
            <%
        }else{
            // Не совсем саксесс...
            %>
                <script>   alert("Your was not deleted!");
                window.location = document.referrer; </script>
            <%
        }

%>
