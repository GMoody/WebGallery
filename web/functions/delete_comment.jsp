<%@ page import="main.Picture" %>

<%
        boolean is_deleted = false; int picture_id; int id_comment;
        // получаем ИД комента для удаляения его из БД, получаем ИД картинки для удаления этого коммента из ЛИСТА КОММЕНТОВ картинки!
        try{
            id_comment = Integer.parseInt(request.getParameter("delete_id"));
            picture_id = Integer.parseInt(request.getParameter("c_picture_id"));

            if(Picture.DeleteComment(id_comment) & picture_id !=0 & id_comment !=0 ){ // запрос удаляет коммент, если тру - то коммент удален.
                // В цикле пройдемся по всем комментам картинки (ИД), и удалим коммент который был удален в запросе!
                for (int i = 0; i < Picture.getPictureInfo(picture_id).getComments().size(); i++)
                    if(Picture.getPictureInfo(picture_id).getComments().get(i).getId_comment() == id_comment)
                        Picture.getPictureInfo(picture_id).getComments().remove(i);

                %><script>alert("Your comment deleted!");
                window.location = document.referrer; </script><%
                }else{
                    %><script>alert("Your was not deleted!");
                    window.location = document.referrer; </script><%
                }
        }catch (Exception e){e.printStackTrace();}
%>
