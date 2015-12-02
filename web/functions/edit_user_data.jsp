<%@ page import="main.User" %>
<%@ page import="functions.Checker" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%
    String login="", pass1="", pass2="", fname="", lname="", email="", keepoldpass="", oldpass="";
    try{ // попробуем получить все необходимые данные
        login = (String) session.getAttribute("user_name");
        pass1 = request.getParameter("pass1");
        pass2 = request.getParameter("pass2");
        fname = request.getParameter("fname");
        lname = request.getParameter("lname");
        email = request.getParameter("email");
        oldpass = User.getUserInfo(session.getAttribute("email").toString()).getPassword();
        keepoldpass = request.getParameter("keepoldpass");
    }catch (Exception e) {
        e.printStackTrace();
    }

    if(keepoldpass==null) // Запускаем обновление данных пользователя с паролем
        if(Checker.checkString(pass1) & Checker.checkString(pass2) & pass1.equals(pass2)){   // Проверим заполнен ли пароль и проверим подтверждение пароля
            try{
                if(User.changeUserData(login,BCrypt.hashpw(pass1, BCrypt.gensalt()),fname,lname,email)){
                    %><script>window.location = "index.jsp";</script><%
                    %><script>alert("User data successfully changed, now log in again!");</script><%
                    %><script>window.location = "index.jsp";</script><%
                    session.invalidate();
                }
                else{
                    %><script>window.location = "index.jsp";</script><%
                    %><script>alert("Error in changing user data, contact system administrator!");</script><%
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }else{  // Если пароли не совпадают или пустые то перекидываем назад
            %><script>window.location = "index.jsp";</script><%
            %><script>alert("Such email already taken!");</script><%
        }

    if(keepoldpass != null) // Запускаем обновление данных юзера без пароля
        try{
            if(User.changeUserData(login,oldpass,fname,lname,email)){
                %><script>window.location = "index.jsp";</script><%
                %><script>alert("User data successfully changed, now log in again!");</script><%
                %><script>window.location = "index.jsp";</script><%
                session.invalidate();
            }else{
                %><script>window.location = "index.jsp";</script><%
                %><script>alert("Such email already taken!");</script><%
            }
        }catch (Exception e){
            e.printStackTrace();
        }
%>