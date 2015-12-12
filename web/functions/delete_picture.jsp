<%--
  Created by IntelliJ IDEA.
  User: r3dz
  Date: 13.12.2015
  Time: 1:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="main.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="functions.Connections" %>

<%      int picture_id = 0; boolean check=false;
        try{
            picture_id = Integer.parseInt(request.getParameter("delete_pic_id"));
        }catch (Exception e){e.printStackTrace();
        out.println("Parameter request exception");
        }

        if(picture_id !=0){ // Если данные пришли верно, то
            // Запускаем метод, в котором запускаются запросы на удаление данных  картиной, в нём же проверяется все ли удалилось и БД,
            // если удалилось все то метод сам удаляет из листа на сайте картинку и дает TRUE!
            // Если вдруг FALSE - НАДО ВРУЧНУЮ СКОПИРОВАТЬ ЗАПРОС ПРОВЕРКИ  из Connections.checkIfPictureWasDeletedCorrectly()
            // запустить ЕГО В БАЗЕ ДАННЫХ и посмотреть что НЕ УДАЛИЛОСЬ!!!! Хотя я проверил на 2 картинках - все работает на ура!
            check = Picture.checkPictureWasDeletedFromDB_If_Success_Delete_It_From_List(picture_id);
        }

        if(check){
            %>
            <script>   alert("Picture was deleted!");
            window.location = document.referrer; </script>
            <%
        }
        else{
                %>
                <script>   alert("Picture was not deleted! Maybe it as already deleted by other admin or user OR picture_id is BAD, check request picture_id!");
                window.location = document.referrer; </script>
                <%
        }

%>
