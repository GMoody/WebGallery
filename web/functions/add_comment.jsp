
<%@ page import="main.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="functions.Connections" %>

<%
    boolean add=false; Integer id_picture=0;
    // Запросим все данные, ид юзера кто добавил, ид картинки куда добавить коммент и сам коммент
    try {
        Integer id_user = Integer.parseInt(request.getParameter("commentator"));
        id_picture = Integer.parseInt(request.getParameter("picture_id"));
        String comment = request.getParameter("comment");
        // Чтобы избежать ошибки в БД, проверим не пустой ли коммент, если пустой, вернём назад.
        if(comment == null | comment.isEmpty()){ %><script> alert("Your comment is empty! Try again!"); window.location = document.referrer; </script><%}
        else{
        // Добавим коммент в БД и в Лист с помощью метода
        add = Picture.sendComment(id_user,id_picture,comment);

            if(add==true){//возращает на страницу назад и обновляет её.
                    // Если коммент успешно добавлен вернём назад и обновим страницу чтобы все видеть!
            %><script>   alert("Thank you for comment!");
            window.location = document.referrer; </script>
            <%

            }else{
                // Если коммент не добавлен, выведем месседж об ошибке!
            %><script>   alert("Error, comment was not added, contact site administration!"); window.location = document.referrer;  </script><%
                        }
        }

    } catch (Exception e){e.printStackTrace();}







%>



