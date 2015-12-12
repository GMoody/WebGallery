<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="functions.FTPHandler" %>
<%@ page import="functions.MainHandler" %>

<%

    if(ServletFileUpload.isMultipartContent(request)){ // Получаем ли форму со смешанными данными
        try {
            %><script>alert("Uploading picture, please wait!");</script><%
            List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request); // Всю форму с данными в лист
            String login= session.getAttribute("user_name").toString(), description="", category="";
            File temp = null;
            boolean flag = false; // Переменная для проверки, необходимо ли залить картинку или нет

            for(FileItem item : multiparts) { // Цикл по данным формы

                if (!item.isFormField()) { // Если попался файл, загружаем и ждём
                    if(item.getSize() != 0){
                        temp = new File(item.getName());
                        item.write(temp);
                        flag = true;
                    }
                }else { // Используем if-else-ы, поскольку java пока не умеет использовать switch со string

                    if (item.getFieldName().equals("description"))
                        description = item.getString();

                    if (item.getFieldName().equals("category"))
                        category = item.getString();
                }
            }

            if (flag){ // Если была загружена ава, тогда отсылаем на ftp и обновляем данные у user-а
                    if(FTPHandler.sendFile(temp, false)){
                        String path = "http://net2ftp.ru/node0/g.tureev@gmail.com/pictures/" + temp.getName();
                        byte result = MainHandler.uploadPicture(session.getAttribute("user_name").toString(), category, description, path);

                        switch (result) {
                            case 1:
                                %><script>alert("Picture successfully uploaded!");</script><%
                                %><script> window.location = document.referrer; </script><%
                                break;
                            default:
                                %><script>alert("Uploading error, contact system administrator!");</script><%
                                %><script> window.location = document.referrer; </script><%
                                break;
                        }

                    }else{
                        %><script>alert("Failed uploading picture :(");</script><%
                        %><script> window.location = document.referrer; </script><%
                    }
            }
        }catch (Exception ex){
            %><script>alert("Error in uploading, contact system administrator!");</script><%
            %><script> window.location = document.referrer; </script><%
        }
    }
%>