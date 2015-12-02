package main;

import functions.Checker;
import functions.Connections;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.ResultSet;
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
        }
    }


    //region Setters
    public void setId_user(int id_user) throws Exception {
        if (Checker.checkNumber(id_user))
            this.id_user = id_user;
        else throw new Exception("Invalid user ID!");
    }

    public void setId_position(int id_position) throws Exception {
        if (Checker.checkNumber(id_position))
            this.id_position = id_position;
        else throw new Exception("Invalid position ID!");
    }

    public void setUser_name(String user_name) throws Exception {
        if (Checker.checkString(user_name))
            this.user_name = user_name;
        else throw new Exception("Invalid user login name!");
    }

    public void setFirst_name(String first_name) throws Exception {
        if (Checker.checkString(first_name))
            this.first_name = first_name;
        else throw new Exception("Invalid user first name!");
    }

    public void setLast_name(String last_name) throws Exception {
        if (Checker.checkString(last_name))
            this.last_name = last_name;
        else throw new Exception("Invalid user last name!");
    }

    public void setEmail(String email) throws Exception {
        if (Checker.checkString(email))
            this.email = email;
        else throw new Exception("Invalid user email!");
    }

    public void setPassword(String password) throws Exception {
        if (Checker.checkString(password))
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
            if(user.email.equals(email))
                return user;
        return null;
    }

    public static User getUserInfoByUserName(String username){
        for(User user : users)
            if(user.user_name.equals(username))
                return user;
        return null;
    }

    //endregion

    public static byte addUser(String user_name, String user_fname, String user_lname, String user_email, String user_pwd) throws SQLException, ClassNotFoundException  {
        // First we check if email is null or empty
        if(user_email != null && !user_email.isEmpty())
            // Second we check if we have email in user-list
            if(getUserInfo(user_email) == null){
                ResultSet rs = Connections.getUserInfo(user_email);
                // Third we check if we have email in database
                if(!rs.next())
                    // Fourth we try to add user to database
                    if(Connections.addUser(user_name, user_fname, user_lname, user_email, BCrypt.hashpw(user_pwd, BCrypt.gensalt())))
                        // Finally we add user to user-list
                        if(createUser(user_email))
                            return 1;            // Successfully added to the database and user list!
                        else return 0;           // Adding to list may fail?
                    else return 0;               // Adding to DB failed
                else {
                    // Seems we have user in DB but not in user-list
                    createUser(user_email);
                    return 2;                    // Successfully added to user list!
                }
            }
            else return -1;                      // User's already registered
        else return -2;                          // Empty or null data
    }

    private static boolean createUser(String user_email) throws SQLException, ClassNotFoundException  {
        ResultSet user_info = Connections.getUserInfo(user_email);
        if(user_info.next()){
            User temp = new User(
                    user_info.getInt(1),     // id_user
                    1,                       // id_position
                    user_info.getString(3),  // user_name
                    user_info.getString(4),  // user_fname
                    user_info.getString(5),  // user_lname
                    user_info.getString(6),  //user_email
                    user_info.getString(7)); //user_pwd
            return true;
        }
        else return false;
    }

    public static boolean addPictureToUser(int id_user, Picture picture){
        try {
            User.getUserInfo(id_user).pictures.add(picture);
            return true;
        } catch (NullPointerException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean changeUserData(String username, String password, String fname, String lname, String email) throws SQLException, ClassNotFoundException
    {
        if(Connections.updateUser(username,password,fname,lname,email))
        {
            try {
                User.getUserInfoByUserName(username).setLast_name(lname);
                User.getUserInfoByUserName(username).setFirst_name(fname);
                User.getUserInfoByUserName(username).setPassword(password);
                User.getUserInfoByUserName(username).setEmail(email);
            }catch (Exception e){
                e.printStackTrace();
            }
            return true;
        }
        else return false;
    }


    public void checkInUserPictures(int id_user, Picture picture){
        // Метод проверяет наличие картинки у пользователя, иначе добавляет ему в его лист с картинками.
        try {
            for (Picture x : getUserInfo(id_user).pictures){
                if(x.getId_picture() != picture.getId_picture())
                    addPictureToUser(id_user, picture);
            }
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
    }

    //endregion
}
