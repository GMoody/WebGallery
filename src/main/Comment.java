package main;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Comment {

    int id_comment;
    int id_picture;
    int id_user;
    String comment;
    Date add_date;

    static List<Comment> comments = new ArrayList<>();

    public Comment(int id_comment, int id_picture, int id_user, String comment, Date add_date) {
        try {
            setId_comment(id_comment);
            setId_picture(id_picture);
            setId_user(id_user);
            setComment(comment);
            setAdd_date(add_date);
            comments.add(this);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

    //region Setters
    public void setId_comment(int id_comment) throws Exception {
        if (checkInt(id_comment))
            this.id_comment = id_comment;
        else throw new Exception("Invalid comment ID!");
    }

    public void setId_picture(int id_picture) throws Exception {
        if (checkInt(id_picture))
            this.id_picture = id_picture;
        else throw new Exception("Invalid picture ID!");
    }

    public void setId_user(int id_user) throws Exception {
        if (checkInt(id_user))
            this.id_user = id_user;
        else throw new Exception("Invalid user ID!");
    }

    public void setComment(String comment) throws Exception {
        if (comment != null && !comment.isEmpty())
            this.comment = comment;
        else throw new Exception("Invalid picture comment!");
    }

    public void setAdd_date(Date add_date) throws Exception {
        if (add_date != null)
            this.add_date = add_date;
        else throw new Exception("Invalid picture upload date!");
    }
    //endregion

    //region Getters
    public int getId_comment() {
        return id_comment;
    }

    public int getId_picture() {
        return id_picture;
    }

    public int getId_user() {
        return id_user;
    }

    public String getComment() {
        return comment;
    }

    public Date getAdd_date() {
        return add_date;
    }

    public static List<Comment> getComments() {
        return comments;
    }
    //endregion

    private boolean checkInt(int number) {
        return number > 0;
    }
}
