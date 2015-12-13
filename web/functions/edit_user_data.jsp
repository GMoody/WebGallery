<%@ page import="functions.Checker" %>
<%@ page import="main.User" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="functions.FTPHandler" %>

<%

    if(ServletFileUpload.isMultipartContent(request)){ // Получаем ли форму со смешанными данными
        try {
            List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request); // Всю форму с данными в лист
            String login= session.getAttribute("user_name").toString(), pass1="", pass2="", fname="", lname="", email="", pwd_old="", is_admin = "", edit_user_login = "";


            File temp = null;
            boolean flag = false; // Переменная для проверки, необходимо ли залить аву или нет

            for(FileItem item : multiparts) { // Цикл по данным формы

                if (!item.isFormField()) { // Если попался файл, загружаем и ждём
                    if(item.getSize() != 0){
                        temp = new File(item.getName());
                        item.write(temp);
                        flag = true;
                    }
                }else { // Используем if-else-ы, поскольку java пока не умеет использовать switch со string

                    if (item.getFieldName().equals("pass1"))
                        pass1 = item.getString();

                    if (item.getFieldName().equals("pass2"))
                        pass2 = item.getString();

                    if (item.getFieldName().equals("fname"))
                        fname = item.getString();

                    if (item.getFieldName().equals("lname"))
                        lname = item.getString();

                    if (item.getFieldName().equals("email"))
                        email = item.getString();

                    if (item.getFieldName().equals("pass0"))
                        pwd_old = item.getString();

                    if(item.getFieldName().equals("is_admin")){
                        if(is_admin != null){is_admin = item.getString();}

                    }

                    if(item.getFieldName().equals("user_login")){
                        if(edit_user_login != null){edit_user_login = item.getString();}

                    }
                }
            }

            if(is_admin != null && edit_user_login != null){login = edit_user_login;}

            if (BCrypt.checkpw(pwd_old, User.getUserInfoByUserName(login).getPassword())) { // Проверяем на совпадение старый пароль

                if(flag){ // Если была загружена ава, тогда отсылаем на ftp и обновляем данные у user-а
                    %><script>alert("Uploading avatar, please wait!");</script><%
                    if(FTPHandler.sendFile(temp, true)){
                        String path = "http://net2ftp.ru/node0/g.tureev@gmail.com/avatars/" + temp.getName();
                        User.updateUserAvatar(login, path);
                    }else{
                        %><script>alert("Failed uploading avatar :(");</script><%
                        %><script> window.location = document.referrer;</script><%
                    }
                }

                if(Checker.checkString(pass1)){ // Если необходимо сменить пароль
                    if(Checker.checkString(pass2) & pass1.equals(pass2)){ // Совпадают ли новые пароли
                        try{
                            if(User.changeUserData(login, BCrypt.hashpw(pass1, BCrypt.gensalt()), fname, lname, email)){
                                %><script>alert("User data successfully changed, now log in again!");</script><%
                                %><script> window.location = document.referrer;</script><%
                                session.invalidate();
                            }else{
                                %><script>alert("Such email is already taken!");</script><%
                                %><script> window.location = document.referrer;</script><%
                            }
                        }catch (Exception e){
                            %><script>alert("Error in changing user data, contact system administrator!1");</script><%
                            %><script> window.location = document.referrer;</script><%
                        }
                    }else {
                        %><script>alert("New passwords don't match!");</script><%
                        %><script> window.location = document.referrer;</script><%
                    }
                }
                else{ // Если менять пароль необходимости нет
                    try{
                        if(User.changeUserData(login, User.getUserInfoByUserName(login).getPassword(), fname, lname, email)){
                            %><script>alert("User data successfully changed!");</script><%
                            %><script> window.location = document.referrer;</script><%
                        }else{
                            %><script>alert("Such email is already taken!");</script><%
                            %><script> window.location = document.referrer;</script><%
                        }
                    }catch (Exception e){
                        %><script>alert("Error in changing user data, contact system administrator!2");</script><%
                        %><script> window.location = document.referrer;</script><%
                    }
                }
            }else{
                %><script>alert("Old password doesn't match!");</script><%
                %><script> window.location = document.referrer;</script><%
            }
        }catch (Exception ex) {
            %><script>alert("Error in changing user data, contact system administrator!3");</script><%
            %><script> window.location = document.referrer;</script><%
        }
    }else{
        %><script>alert("Error in changing user data, contact system administrator!4");</script><%
        %><script> window.location = document.referrer;</script><%
    }

%>