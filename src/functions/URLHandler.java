package functions;

public class URLHandler {

    public static String makeURL(String url, String sort, boolean type){ // Type: ASC - true, DESC - false
        if(url.contains("sort"))
            if(type) url = url.replace(url.substring(url.indexOf("sort") - 1, url.length()), "") + "&sort=" + sort + "_asc";
            else url = url.replace(url.substring(url.indexOf("sort") - 1, url.length()), "") + "&sort=" + sort + "_desc";
        else if(url.contains("page"))
            if(type) url = url + "&sort=" + sort + "_asc";
            else url = url + "&sort=" + sort + "_desc";
        else if(url.contains("gallery"))
            if (type) url = url + "&page=1&sort=" + sort + "_asc";
            else url = url + "&page=1&sort=" + sort + "_desc";
        else
            if (type) url = url + "page=1&sort=" + sort + "_asc";
            else url = url + "page=1&sort=" + sort + "_desc";
        return url;
    }

    public static String makePage(String url, int page){
        if(!url.contains("index"))
            url = url + "index.jsp?page=";

        if(url.contains("&")){
            String after = url.substring(url.indexOf("&"));
            url = url.replace(url.substring(url.indexOf("page"), url.length()), "");
            url = url + "page=" + page + after;
        }else if(url.contains("page")){
            url = url.replace(url.substring(url.indexOf("page"), url.length()), "");
            url = url + "page=" + page;
        }else url = url + "page=" + page;
        return url;
    }

    public static String makeGalleryPage(String url, int page){
        if(url.contains("&"))
            if(url.contains("sort")){
                String after = url.substring(url.indexOf("sort") - 1);
                url = url.replace(url.substring(url.indexOf("page"), url.length()), "");
                url = url + "page=" + page + after;
            }else{
                url = url.replace(url.substring(url.indexOf("page"), url.length()), "");
                url = url + "page=" + page;
            }
        else url = url + "&page=" + page;
        return url;
    }
}
