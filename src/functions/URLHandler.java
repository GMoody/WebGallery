package functions;

public class URLHandler {

    public static String makeDESC(String url, String sort){
        if(!url.contains("index"))
            return url = url + "index.jsp?page=1&sort=" + sort + "_desc";
        else{
            if(url.contains("asc")){
                return url = url.replace(url.substring(url.indexOf("&"), url.length()), "") + "&sort=" + sort + "_desc";
            }else if(url.contains("desc"))
                return url; // Bug here
            else return url = url + "&sort=" + sort + "_desc";
        }
    }

    public static String makeASC(String url, String sort){
        if(!url.contains("index"))
            return url = url + "index.jsp?page=1&sort=" + sort + "_asc";
        else{
            if(url.contains("desc")){
                return url = url.replace(url.substring(url.indexOf("&"), url.length()), "") + "&sort=" + sort + "_asc";
            }else if(url.contains("asc"))
                return url; // Bug here
            else return url = url + "&sort=" + sort + "_asc";
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
