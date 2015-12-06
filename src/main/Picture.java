package main;

import functions.Checker;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

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

    public static List<Picture> sortASC(){
        List<Picture> temp = pictures;
        Collections.sort(temp);
        return temp;
    }

    public static List<Picture> sortReverse(){
        List<Picture> temp = pictures;
        Collections.sort(temp, Collections.reverseOrder());
        return temp;
    }

    public static List<Picture> sortRatingASC(){
        List<Picture> temp = new ArrayList<>();

        for(Picture_Statistics picture_statistics : Picture_Statistics.sortRatingASC()){
            temp.add(getPictureInfo(picture_statistics.getId_picture()));
        }

        return temp;
    }

    public static List<Picture> sortRatingDESC(){
        List<Picture> temp = sortRatingASC();
        Collections.sort(temp, Collections.reverseOrder());
        return temp;
    }


    @Override
    public int compareTo(Picture o) {
        return getUpl_date().compareTo(o.upl_date);
    }



    //endregion
}
