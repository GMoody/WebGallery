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


        boolean is_deleted = false; int id_user=0; boolean delete_comments = false; boolean delete_likes = false; boolean delete_user_stats = false;
        boolean delete_user_pic_stat = false; boolean delete_user_pics = false;
        try
        {

         id_user = Integer.parseInt(request.getParameter("delete_user_id"));

        }catch (Exception e)
        {
            e.printStackTrace(); out.println("request.getparameter error");
        }

         if(id_user !=0){ // Если данные получены

             // Начём адское удаление всего контента связанного с этим юзером из базы данных

                    // Заранее извиняюсь что не пихнул эти методы в класс юзер,  но так как они доступны только админу и только в одном месте не стал этого делать, да и ошибки так проверять было проще!
                 delete_comments = Connections.deleteAllUserComments(id_user); // удаляем комменты юзера и ВСЕ комменты его картинок
                 delete_likes = Connections.deleteAllUserLikes(id_user);  // удаляем лайки юзра и ВСЕ лайки на его картинках
                 delete_user_stats = Connections.deleteAllUserStatistics(id_user); // удаляем его статистику
                 delete_user_pic_stat  = Connections.deleteAllUserPictureStatistics(id_user); // удаляем статистику его пикчей
                 delete_user_pics = Connections.deleteAllUserPictures(id_user); // удаляем его пикчи


             if(delete_comments == true & delete_likes == true & delete_user_stats == true & delete_user_pics == true & delete_user_pics == true){
                 // Если всё прошло успешно, а оно пройдёт!!! То удалим юзера из листа и удалим все его пикчи из листа.
                 //out.println("good all 5 is true, now delete user");
                 is_deleted = User.deleteUserByAdmin(id_user);
                 Picture.deleteUserPictureFromList(id_user); // циклом пройдем по всем картинкам, удалим все картинки этого пользователя из листа, что на главной странице не было ошибок

             }else{
                 //
                 //В случае ошибки, выведем все параметры на экран, чтобы было видно в каком методе выдало FALSE чтобы знать куда смотреть и
                 // где исправлять, при успешном выполнении страница быстро обновитсья по скрипту ниже и это не будет видно!
                 out.println("bad");
                 out.println("delete comments:"+delete_comments);
                 out.println("delete likes:"+delete_likes);
                 out.println("delete user stats:"+delete_user_stats);
                 out.println("delete pic stats:"+delete_user_pic_stat );
                 out.println("delete pic:"+delete_user_pics );
             }




            }

            if(is_deleted){
                %>
                        <script>   alert("User was successfully deleted!");
                        window.location = document.referrer; </script>
                <%
            }
            else{
                %>
                <script>  alert("User was not deleted, maybe it is already deleted by someone else!");
                window.location = document.referrer; </script>
                <%
            }



%>