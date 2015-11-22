package main;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Picture {

    private int id_picture;
    private int id_category;
    private int upl_user_id;
    private Date upl_date;
    private String description;
    private List<Comment> comments;

    // General list with pictures
    static List<Picture> pictures = new ArrayList<>();

    public Picture(int id_picture, int id_category, int upl_user_id, Date upl_date, String description) {
        try {
            setId_picture(id_picture);
            setId_category(id_category);
            setUpl_user_id(upl_user_id);
            setUpl_date(upl_date);
            setDescription(description);
            pictures.add(this);
            this.comments = new ArrayList<>();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

    //region Setters
    public void setId_picture(int id_picture) throws Exception {
        if (checkInt(id_picture))
            this.id_picture = id_picture;
        else throw new Exception("Invalid picture ID!");
    }

    public void setId_category(int id_category) throws Exception {
        if (checkInt(id_category))
            this.id_category = id_category;
        else throw new Exception("Invalid picture category!");
    }

    public void setUpl_user_id(int upl_user_id) throws Exception {
        if (checkInt(upl_user_id))
            this.upl_user_id = upl_user_id;
        else throw new Exception("Invalid user ID!");
    }

    public void setUpl_date(Date upl_date) throws Exception {
        if (upl_date != null)
            this.upl_date = upl_date;
        else throw new Exception("Invalid picture upload date!");
    }

    private void setDescription(String description) throws Exception {
        if (description != null && !description.isEmpty())
            this.description = description;
        else throw new Exception("Invalid picture description!");
    }
    //endregion

    //region Getters
    public int getId_picture() {
        return id_picture;
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

    public static List<Picture> getPictures() {
        return pictures;
    }

    public List<Comment> getComments() {
        return comments;
    }

    //endregion

    //region Methods
    public static Picture getPictureInfo(int id_picture){
        for(Picture picture : pictures)
            if(picture.id_picture == id_picture)
                return picture;
        return null;
    }

    private boolean checkInt(int number) {
        return number > 0;
    }
    //endregion
}
