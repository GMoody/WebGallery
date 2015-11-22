package main;

import functions.Connections;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class User {

    private int id_user;
    private int id_position;
    private String user_name;
    private String first_name;
    private String last_name;
    private String email;
    private String password;
    private List<Picture> pictures;    // Each user has his own list with pictures

    // General list with users
    public static List<User> users = new ArrayList<>();

    public User(int id_user, int id_position, String user_name, String first_name, String last_name, String email, String password) {
        try {
            setId_user(id_user);
            setId_position(id_position);
            setUser_name(user_name);
            setFirst_name(first_name);
            setLast_name(last_name);
            setEmail(email);
            setPassword(password);
            users.add(this);
            this.pictures = new ArrayList<>();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }


    //region Setters
    public void setId_user(int id_user) throws Exception {
        if (checkInt(id_user))
            this.id_user = id_user;
        else throw new Exception("Invalid user ID!");
    }

    public void setId_position(int id_position) throws Exception {
        if (checkInt(id_position))
            this.id_position = id_position;
        else throw new Exception("Invalid position ID!");
    }

    public void setUser_name(String user_name) throws Exception {
        if (checkString(user_name))
            this.user_name = user_name;
        else throw new Exception("Invalid user login name!");
    }

    public void setFirst_name(String first_name) throws Exception {
        if (checkString(first_name))
            this.first_name = first_name;
        else throw new Exception("Invalid user first name!");
    }

    public void setLast_name(String last_name) throws Exception {
        if (checkString(last_name))
            this.last_name = last_name;
        else throw new Exception("Invalid user last name!");
    }

    public void setEmail(String email) throws Exception {
        if (checkString(email))
            this.email = email;
        else throw new Exception("Invalid user email!");
    }

    public void setPassword(String password) throws Exception {
        if (checkString(password))
            this.password = password;
        else throw new Exception("Invalid user password!");
    }
    //endregion

    //region Getters
    public int getId_user() {
        return id_user;
    }

    public int getId_position() {
        return id_position;
    }

    public String getUser_name() {
        return user_name;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public List<Picture> getPictures() {
        return pictures;
    }

    public static List<User> getUsers() {
        return users;
    }
    //endregion

    //region Methods

    //region getUserInfo
    // Also used to check if user is registered
    public static User getUserInfo(int id_user){
        for(User user : users)
            if(user.id_user == id_user)
                return user;
        return null;
    }

    public static User getUserInfo(String email){
        for(User user : users)
            if(user.email == email)
                return user;
        return null;
    }
    //endregion

    public static byte addUser(String user_name, String user_fname, String user_lname, String user_email, String user_pwd) throws SQLException {
        if(user_email != null && user_email.isEmpty())
            if(getUserInfo(user_email) == null)
                if(Connections.addUser(user_name, user_fname, user_lname, user_email, BCrypt.hashpw(user_pwd, BCrypt.gensalt())))
                    return 1;   // Success!
                else return 0;  // Adding to DB failed
            else return -1;     // User's already registered
        else return -2;         // Empty or null data
    }

    private boolean checkString(String string) {
        return (string != null && !string.isEmpty());
    }

    private boolean checkInt(int number) {
        return number > 0;
    }
    //endregion
}
