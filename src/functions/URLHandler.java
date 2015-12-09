package functions;

public class URLHandler {

    public static String makeDESC(String url, String sort){
        if(!url.contains("index"))
            return url = url + "index.jsp?page=1&sort=" + sort + "_desc";
        else{
            if(url.contains("&")) {
                url = url.replace(url.substring(url.indexOf("&"), url.length()), "") + "&sort=" + sort + "_desc";
                return url;
            }else{
                url = url + "&sort=" + sort + "_desc";
                return url;
            }
        }
    }

    public static String makeASC(String url, String sort){
        if(!url.contains("index"))
            return url = url + "index.jsp?page=1&sort=" + sort + "_asc";
        else{
            if(url.contains("&")) {
                url = url.replace(url.substring(url.indexOf("&"), url.length()), "") + "&sort=" + sort + "_asc";
                return url;
            }else{
                url = url + "&sort=" + sort + "_asc";
                return url;
            }
        }
    }

    public static String makePage(String url, int page){
        if(!url.contains("index"))
            url = url + "index.jsp?page=";

        if(url.contains("&")){
            String after = url.substring(url.indexOf("&"));
            url = url.replace(url.substring(url.indexOf("page"), url.length()), "");
            url = url + "page=" + page + after;
        }
        else{
            url = url.replace(url.substring(url.indexOf("page"), url.length()), "");
            url = url + "page=" + page;
        }

        return url;
    }
}
