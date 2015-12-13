package main;

import functions.Checker;
import functions.Connections;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class Picture implements Comparable<Picture>{

    private int id_picture;
    private int id_category;
    private int upl_user_id;
    private Date upl_date;
    private String description;
    private String picture_url;
    private List<Comment> comments;

    // General list with pictures
    public static List<Picture> pictures = new ArrayList<>();

    public Picture(int id_picture, int id_category, int upl_user_id, Date upl_date, String description, String picture_url) {
        try {
            setId_picture(id_picture);
            setId_category(id_category);
            setUpl_user_id(upl_user_id);
            setUpl_date(upl_date);
            setDescription(description);
            setPicture_url(picture_url);
            this.comments = new ArrayList<>();
            pictures.add(this);
        } catch (Exception e) {
            System.out.println("Picture Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    //region Setters
    public void setId_picture(int id_picture) {
        if(Checker.checkNumber(id_picture))
            this.id_picture = id_picture;
    }

    public void setId_category(int id_category) {
        if(Checker.checkNumber(id_category))
            this.id_category = id_category;
    }

    public void setUpl_user_id(int upl_user_id) {
        if(Checker.checkNumber(upl_user_id))
            this.upl_user_id = upl_user_id;
    }

    public void setUpl_date(Date upl_date) {
        this.upl_date = upl_date;
    }

    public void setDescription(String description) {
        if(Checker.checkString(description))
            this.description = description;
    }

    public void setPicture_url(String picture_url) {
        if(Checker.checkString(picture_url))
            this.picture_url = picture_url;
    }
    //endregion

    //region Getters
    public int getId_picture() {
        return this.id_picture;
    }

    public int getId_category() {
        return id_category;
    }

    public int getUpl_user_id() {
        return upl_user_id;
    }

    public Date getUpl_date() {
        return upl_date;
    }

    public String getDescription() {
        return description;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public String getPicture_url() {
        return picture_url;
    }

    //endregion

    //region Methods
    public static Picture getPictureInfo(int id_picture) {
        for (Picture picture : pictures)
            if (picture.id_picture == id_picture)
                return picture;
        return null;
    }


    //region Picture Sorting
    public static List<Picture> sortASC(int sort){
        switch (sort){
            case 0: // Date sorting
                List<Picture> temp = pictures;
                Collections.sort(temp);
                return temp;
            case 1: // Downloads sorting
                return Picture_Statistics.sortDownloadsASC().stream().map(statistics -> getPictureInfo(statistics.getId_picture())).collect(Collectors.toList());
            case 2: // Rating sorting
                return Picture_Statistics.sortRatingASC().stream().map(statistics -> getPictureInfo(statistics.getId_picture())).collect(Collectors.toList());
        }
        return null;
    }

    public static List<Picture> sortDESC(int sort){
        List<Picture> temp = null;
        switch (sort){
            case 0: // Date sorting
                temp = sortASC(0);
                Collections.reverse(temp);
                break;
            case 1: // Downloads sorting
                temp = sortASC(1);
                Collections.reverse(temp);
                break;
            case 2: // Rating sorting
                temp = sortASC(2);
                Collections.reverse(temp);
                break;
        }
        return temp;
    }

    public static List<Picture> sortGalleryASC(int sort, String user_name){
        List<Picture> temp = null;
        List<Picture> user_pictures = new ArrayList<>();
        int user_id = User.getUserInfoByUserName(user_name).getId_user();

        switch (sort){
            case 0: // Date sorting
                temp = sortASC(0);
                break;
            case 1: // Downloads sorting
                temp = sortASC(1);
                break;
            case 2: // Rating sorting
                temp = sortASC(2);
                break;
        }

        for (Picture picture : temp)
            if(picture.getUpl_user_id() == user_id)
                user_pictures.add(picture);

        return user_pictures;
    }

    public static List<Picture> sortGalleryDESC(int sort, String user_name){
        List<Picture> temp = null;
        switch (sort){
            case 0: // Date sorting
                temp = sortGalleryASC(0, user_name);
                Collections.reverse(temp);
                break;
            case 1: // Downloads sorting
                temp = sortGalleryASC(1, user_name);
                Collections.reverse(temp);
                break;
            case 2: // Rating sorting
                temp = sortGalleryASC(2, user_name);
                Collections.reverse(temp);
                break;
        }
        return temp;
    }
    //endregion Picture Sorting

    @Override
    public int compareTo(Picture o) {
        return this.getUpl_date().compareTo(o.upl_date);
    }

    public static void addCommentToPicture(int id_picture){
        try {
            ResultSet rs = Connections.GetPictureComments(id_picture);

            while(rs.next())
                if (Picture.getPictureInfo(id_picture).getComments().size() > 0) {
                    boolean check = true;
                    for (int i = 0; i < Picture.getPictureInfo(id_picture).getComments().size(); i++)
                        if (Picture.getPictureInfo(id_picture).getComments().get(i).getId_comment() == rs.getInt(1))
                            check = false;
                    if(check)
                        getPictureInfo(id_picture).getComments().add(new Comment(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(5), rs.getDate(4)));
                } else getPictureInfo(id_picture).getComments().add(new Comment(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(5), rs.getDate(4)));
        } catch (SQLException | ClassNotFoundException | NullPointerException e) {
            e.printStackTrace();
        }
    }

    public static boolean sendComment(int id_user, int id_picture, String commentary) throws SQLException, ClassNotFoundException{
        try {
            return Connections.AddComment(id_user, id_picture, commentary);
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public static boolean DeleteComment (int id_comment) throws SQLException, ClassNotFoundException{
        try{
            return Connections.DeleteComment(id_comment);
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public static boolean likePicture (int user_id, int picture_id) throws  SQLException, ClassNotFoundException{
        boolean is_liked = false; // добавлен ли новый лайк, в БД, если false то ошибка в БД!

        try{
            is_liked = Connections.addLike(user_id,picture_id);

            if(is_liked){ // Если лайкнул успешно, кидаем запрос в БД на добавление +1 к тотал вотед и добавляем в листе к картинке.
                if(Connections.addLikeToTotalVoted(picture_id)){
                    int newvoted = Picture_Statistics.getPicture_statistics(picture_id).getTotal_voted()+1;
                    Picture_Statistics.getPicture_statistics(picture_id).setTotal_voted(newvoted);
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }

        return is_liked;
    }

    public static boolean allowUserLike (int user_id, int picture_id) throws  SQLException, ClassNotFoundException{
        try{
            return Connections.checkLike(user_id, picture_id); // проверим, если вернет ТРУ то лайк уже есть, если фалсе то можно добавлять новый лайк
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public static boolean unlikePicture(int user_id, int picture_id) throws  SQLException, ClassNotFoundException {
        boolean is_unliked = false;

        try{
            is_unliked = Connections.deleteLike(user_id,picture_id);

            if(is_unliked){
                if(Connections.deleteLikeFromTotalVoted(picture_id)){
                    int newvoted = Picture_Statistics.getPicture_statistics(picture_id).getTotal_voted()-1;
                    Picture_Statistics.getPicture_statistics(picture_id).setTotal_voted(newvoted);
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }

        return  is_unliked;
    }




    //endregion
}
