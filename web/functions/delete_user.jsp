<%@ page import="main.User" %>
<%@ page import="functions.Connections" %>
<%@ page import="main.Picture" %><%--
  Created by IntelliJ IDEA.
  User: r3dz
  Date: 12.12.2015
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%



        int id_user=0; boolean check=false;
        try
        { // запращиваем параметры

         id_user = Integer.parseInt(request.getParameter("delete_user_id"));

        }catch (Exception e)
        {
            e.printStackTrace(); out.println("request.getparameter error");
        }

         if(id_user !=0) { // Если данные получены запускаем метод каскадного удаления, проводит все запросы на удаления
             // любого контента связанного с этим юзером, после запускает запрос проверку, где дает Резалт сет, если он не пустой
             // значит что-то осталось и выдаст FALSE. Если резаль сет пустой то удаляет самого юзера и его пички из ЛИСТОВ НА САЙТЕ и выдает TRUE.

             //ЕСЛИ FALSE НАДО ВРУЧНУЮ СКОПИРОВАТЬ ЗАПРОС ПРОВЕРКИ  из Connections.checkIfUserWasDeletedCorrectly()
             // запустить ЕГО В БАЗЕ ДАННЫХ и посмотреть что НЕ УДАЛИЛОСЬ!!!! Хотя запросы все простые и удаления идут в правильном порядке.

             check = User.checkUserWasDeletedFromDB_If_Success_Delete_It_From_List(id_user);
         }

                if(check){
                %>
                    <script>   alert("User was successfully deleted!");
                    window.location = document.referrer; </script>
                <%
                }
                else{
                %>
                    <script>  alert("User was not deleted, maybe it is already deleted by someone else, OR user_id is BAD, check request picture_id!");
                    window.location = document.referrer; </script>
                <%
                    }





%>