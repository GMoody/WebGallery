<%@ page import="main.Picture" %>

<%
    // Запросим все данные, ид юзера кто добавил, ид картинки куда добавить коммент и сам коммент
    try {
        String comment = request.getParameter("comment");

        if(comment == null | comment.isEmpty()){ // Чтобы избежать ошибки в БД, проверим не пустой ли коммент, если пустой, вернём назад.
            %><script> alert("Your comment is empty! Try again!");
            window.location = document.referrer; </script><%
        }else if(Picture.sendComment(Integer.parseInt(request.getParameter("commentator")),Integer.parseInt(request.getParameter("picture_id")),comment)){
            %><script>alert("Thank you for comment!"); // Если коммент успешно добавлен вернём назад и обновим страницу чтобы все видеть!
            window.location = document.referrer; </script><%

        }else{ // Если коммент не добавлен, выведем месседж об ошибке!
            %><script>alert("Error, comment was not added, contact site administration!");
            window.location = document.referrer;</script><%
        }
    }catch (Exception e){e.printStackTrace();}
%>



