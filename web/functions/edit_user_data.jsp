<%@page import="java.util.*" %>
<%@page import="java.lang.System.*" %>
<%@page import="main.User" %>
<%@page import="java.sql.*" %>
<%@ page import="functions.Connections" %>
<%@ page import="functions.Checker" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%
    String login="", pass1="", pass2="", fname="", lname="", email="", keepoldpass="", oldpass="";
    try { // попробуем получить все необходимые данные
        login = (String) session.getAttribute("user_name");
        pass1 = request.getParameter("pass1");
        pass2 = request.getParameter("pass2");
        fname = request.getParameter("fname");
        lname = request.getParameter("lname");
        email = request.getParameter("email");
        oldpass = User.getUserInfo(session.getAttribute("email").toString()).getPassword().toString();
        keepoldpass = request.getParameter("keepoldpass");
    }catch (Exception e) {out.println(e); out.println("catch_edit_user_data.jsp");}



    if(keepoldpass==null)
    { // Запускаем обновление данных пользователя с паролем
        if(Checker.checkString(pass1) & Checker.checkString(pass2) & pass1.equals(pass2)){   // Проверим заполнен ли пароль и проверим подтверждение пароля

            try {
                String hashedpass = BCrypt.hashpw(pass1, BCrypt.gensalt()); // хешируем новый пароль

                boolean test = User.ChaneUserData(login,hashedpass,fname,lname,email);
                if(test){
                            %><script>
                                window.history.back(-1); // бросит нас назад на 1 страницу
                                alert("User data successfully changed!");
                            </script><%
                }
                else{
                            %><script>
                                window.history.back(-1); // бросит нас назад на 1 страницу
                                alert("Error in changing user data, contact system administrator!");
                            </script><%
                }


            } catch (Exception e){out.println(e);}


        }
        else  // Если пароли не совпадают или пустые то перекидываем назад
        {
            %><script>
            window.history.back(-1); // бросит нас назад на 1 страницу
            alert("Error in new password confirm,new password does not match or empty!");
            </script><%
        }
    }

    if(keepoldpass != null) // Запускаем обновление данных юзера без пароля
    {

        try {

            boolean test = User.ChaneUserData(login,oldpass,fname,lname,email);
            if(test){
                        %><script>
                            window.history.back(-1); // бросит нас назад на 1 страницу
                            alert("User data successfully changed!");
                        </script><%
            }

            else{
                        %><script>
                            window.history.back(-1); // бросит нас назад на 1 страницу
                            alert("Error in changing user data, contact system administrator!");
                        </script><%
            }

        }catch (Exception e){out.println(e); out.println("eception");}
    }






%>