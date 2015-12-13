<%@ page import="main.Picture" %>
<%@ page import="java.util.List" %>


<%
    List<Picture> pictures = null;
    String user_name = request.getParameter("user");

    if(request.getParameter("sort") != null){
        if(request.getParameter("sort").equals("date_asc"))
            pictures = Picture.sortGalleryASC(0, user_name);

        if(request.getParameter("sort").equals("date_desc"))
            pictures = Picture.sortGalleryDESC(0, user_name);

        if(request.getParameter("sort").equals("downloads_asc"))
            pictures = Picture.sortGalleryASC(1, user_name);

        if(request.getParameter("sort").equals("downloads_desc"))
            pictures = Picture.sortGalleryDESC(1, user_name);

        if(request.getParameter("sort").equals("rating_asc"))
            pictures = Picture.sortGalleryASC(2, user_name);

        if(request.getParameter("sort").equals("rating_desc"))
            pictures = Picture.sortGalleryDESC(2, user_name);

    }else pictures = Picture.sortGalleryDESC(0, user_name);

    request.setAttribute("list", pictures);
    response.sendRedirect("../gallery.jsp?user=" + user_name + "&page=1&sort=" + request.getParameter("sort"));

%>