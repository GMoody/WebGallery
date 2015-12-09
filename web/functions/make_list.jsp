<%@ page import="functions.MainHandler" %>
<%@ page import="main.Picture" %>
<%@ page import="java.util.List" %>
<%

    List<Picture> pictures = null;

    if(request.getParameter("sort") != null){
        if(request.getParameter("sort").equals("date_asc"))
            pictures = Picture.sortASC(0);

        if(request.getParameter("sort").equals("date_desc"))
            pictures = Picture.sortDESC(0);

        if(request.getParameter("sort").equals("downloads_asc"))
            pictures = Picture.sortASC(1);

        if(request.getParameter("sort").equals("downloads_desc"))
            pictures = Picture.sortDESC(1);

        if(request.getParameter("sort").equals("rating_asc"))
            pictures = Picture.sortASC(2);

        if(request.getParameter("sort").equals("rating_desc"))
            pictures = Picture.sortDESC(2);

    }else pictures = MainHandler.getMainPictures();

    request.setAttribute("list", pictures);
    response.sendRedirect("../index.jsp");
%>
