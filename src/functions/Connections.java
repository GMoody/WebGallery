package functions;

import java.sql.*;

public class Connections {

    public Connection getConnection() throws SQLException, ClassNotFoundException {

        String username, password;
        username = password = "t131568";
        String servername = "dev.vk.edu.ee";
        String database = "db_Kulakov";
        Class.forName("org.postgresql.Driver");

        try {
            return DriverManager.getConnection("jdbc:postgresql://" + servername + "/" + database, username, password);
        } catch (SQLException e) {
            System.out.println("Connection with database failed!");
            return null;
        }
    }

    private static ResultSet queryExecuter(String sql) throws SQLException, ClassNotFoundException {
        Connection conn = new Connections().getConnection();
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        conn.close();
        return rs;
    }

    private static boolean queryUpdater(String sql) throws SQLException, ClassNotFoundException {
        Connection conn = new Connections().getConnection();
        Statement st = conn.createStatement();
        return st.executeUpdate(sql) > 0;
    }

    public static ResultSet getUserInfo(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_user WHERE email = '" + email + "'";
        return queryExecuter(sql);
    }

    public static ResultSet getUserInfo(int id_user) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_user WHERE id_user = '" + id_user + "'";
        return queryExecuter(sql);
    }

    public static boolean addUser(String user_name, String user_fname, String user_lname, String user_email, String user_pwd) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO webgallery.t_user (id_position, user_name, first_name, last_name, email, password) " +
                "VALUES (1, '" + user_name + "', '" + user_fname + "', '" + user_lname + "', '" + user_email + "', '" + user_pwd + "')";
        return queryUpdater(sql);
    }

    public static ResultSet getAllPictures() throws SQLException, ClassNotFoundException {
        // Свортировка: сначала идут более свежие картинки.
        String sql = "SELECT * FROM webgallery.t_picture ORDER BY upl_date DESC";
        return queryExecuter(sql);
    }

    public static ResultSet getCategories() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_category";
        return queryExecuter(sql);
    }

    public static ResultSet getPositions() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_position";
        return queryExecuter(sql);
    }

    public static ResultSet getUsers() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_user";
        return queryExecuter(sql);
    }

    public static ResultSet getUsersStatistics() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_user_statistics";
        return queryExecuter(sql);
    }

    public static ResultSet getPicturesStatistics() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM webgallery.t_picture_statistics";
        return queryExecuter(sql);
    }

    public static boolean updateUser(String username, String password, String fname, String lname, String email) throws SQLException, ClassNotFoundException {

        if(checkEmail(email,username)) {
            String query = "UPDATE webgallery.t_user SET first_name = '" + fname + "', last_name= '" + lname + "', email= '" + email + "', password = '" + password + "' WHERE t_user.user_name = '" + username + "'";
            return queryUpdater(query);
        }
        else return false;
    }

    public static boolean updateUserAvatar(String username, String avatar) throws SQLException, ClassNotFoundException {
        String query = "UPDATE webgallery.t_user SET avatar = '" + avatar + "' WHERE t_user.user_name = '" + username + "'";
        return queryUpdater(query);
    }

    public static boolean checkEmail(String email, String username) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM webgallery.t_user WHERE t_user.email = '"+email+"' AND t_user.user_name != '"+username+"'";
        ResultSet st = queryExecuter(query);
        return !st.next();
    }

    public static ResultSet GetPictureComments(int picture_id) throws SQLException, ClassNotFoundException{

        String query="SELECT * FROM webgallery.t_comment as C WHERE C.id_picture = '"+picture_id+"' ORDER BY 4 ASC";
        return queryExecuter(query);
    }

    public static boolean AddComment(int id_user, int id_picture, String comment) throws SQLException, ClassNotFoundException{
        String query="INSERT INTO webgallery.t_comment (id_picture,id_user,add_date,comment) VALUES ('"+id_picture+"','"+id_user+"',CURRENT_DATE,'"+comment+"');";
        return queryUpdater(query);
    }

    public  static  boolean DeleteComment(int id_comment) throws  SQLException, ClassNotFoundException{
        String query="DELETE FROM webgallery.t_comment WHERE id_comment ='"+id_comment+"'";
        return queryUpdater(query);
    }

    public static boolean addLike (int user_id, int picture_id) throws SQLException, ClassNotFoundException{
        String query = "INSERT INTO webgallery.t_Like (id_user,id_picture) VALUES ('"+user_id+"', '"+picture_id+"');";
       return  queryUpdater(query);
    }

    public static boolean checkLike (int user_id, int picture_id) throws  SQLException, ClassNotFoundException{
        String query = "SELECT * FROM webgallery.t_Like WHERE id_user = '"+user_id+"' AND id_picture = '"+picture_id+"'";
        ResultSet st = queryExecuter(query);
        if(st.next()){return true;}else{return false;}
    }

    public static boolean deleteLike(int user_id, int picture_id) throws  SQLException, ClassNotFoundException{
        String query = "DELETE FROM webgallery.t_Like WHERE id_user = '"+user_id+"' and id_picture = '"+picture_id+"'";
        return  queryUpdater(query);
    }

    public static boolean addLikeToTotalVoted(int picture_id) throws  SQLException, ClassNotFoundException{
        String query ="UPDATE webgallery.t_picture_statistics SET total_voted = total_voted + 1 WHERE id_picture = '"+picture_id+"'";
        return queryUpdater(query);
    }

    public static  boolean deleteLikeFromTotalVoted(int picture_id) throws SQLException, ClassNotFoundException{
        String query ="UPDATE webgallery.t_picture_statistics SET total_voted = total_voted - 1 WHERE id_picture = '"+picture_id+"'";
        return queryUpdater(query);
    }

    public static boolean deleteUser(int user_id) throws  SQLException, ClassNotFoundException{

        String query ="DELETE FROM webgallery.t_user WHERE t_user.id_user = '"+user_id+"'";
        return queryUpdater(query);
    }





    public static boolean deleteAllUserComments(int user_id) throws SQLException, ClassNotFoundException{

        String query2="DELETE FROM webgallery.t_comment where id_user = '"+user_id+"'";
        return  queryUpdater(query2);

    }

    public static boolean deleteAllAlienCommentsFromUserPictures(int user_id) throws SQLException, ClassNotFoundException{
        String query_3="DELETE FROM webgallery.t_comment where t_comment.id_picture in ( SELECT id_picture FROM webgallery.t_picture where t_picture.upl_user_id = '"+user_id+"' )";
        return queryUpdater(query_3);
    }

    public static boolean deleteAllAlienLikesFromUserPictures(int user_id) throws SQLException,ClassNotFoundException{
        String query3="DELETE FROM webgallery.t_Like where t_Like.id_picture in ( SELECT id_picture FROM webgallery.t_picture where t_picture.upl_user_id = '"+user_id+"' )";
        return queryUpdater(query3);
    }

    public static boolean deleteAllUserLikes(int user_id) throws SQLException, ClassNotFoundException{

        String query2="DELETE FROM webgallery.t_Like where id_user ='"+user_id+"'";
        return queryUpdater(query2);

    }

    public static boolean deleteAllUserStatistics(int user_id) throws SQLException, ClassNotFoundException{

        String query2="DELETE FROM webgallery.t_user_statistics where id_user ='"+user_id+"'";
        return queryUpdater(query2);

    }

    public static boolean deleteAllUserPictureStatistics(int user_id) throws SQLException, ClassNotFoundException{


        String query2="DELETE FROM webgallery.t_picture_statistics WHERE id_picture in ( SELECT t_picture_statistics.id_picture FROM webgallery.t_picture_statistics JOIN webgallery.t_picture ON t_picture_statistics.id_picture = t_picture.id_picture where upl_user_id = '"+user_id+"')";
        return queryUpdater(query2);
    }

    public static boolean deleteAllUserPictures(int user_id) throws SQLException, ClassNotFoundException{


        String query2="DELETE FROM webgallery.t_picture where upl_user_id = '"+user_id+"'";
        return queryUpdater(query2);
    }

    public static ResultSet checkIfUserWasDeletedCorrectly(int id_user) throws SQLException, ClassNotFoundException{
        String query="SELECT * FROM webgallery.t_user as U LEFT join webgallery.t_picture as P ON U.id_user = P.upl_user_id LEFT join webgallery.t_comment as C ON U.id_user = C.id_user LEFT join webgallery.t_like as L ON U.id_user = L.id_user LEFT join webgallery.t_user_statistics as US ON U.id_user = US.id_user where U.id_user = '"+id_user+"'";
        return queryExecuter(query);
    }




    public static boolean deleteCommentsFromPictureByID (int picture_id) throws SQLException, ClassNotFoundException{
        String query="DELETE FROM webgallery.t_like as L where L.id_picture = '"+picture_id+"'";
        return queryUpdater(query);

    }

    public static boolean deleteLikesFromPictureByID (int picture_id) throws SQLException, ClassNotFoundException{
        String query="DELETE FROM webgallery.t_comment as T where T.id_picture = '"+picture_id+"'";
        return  queryUpdater(query);
    }

    public static boolean deletePictureStatisticsByID (int picture_id) throws SQLException, ClassNotFoundException{
        String query ="DELETE FROM webgallery.t_picture_statistics as P where P.id_picture = '"+picture_id+"'";
        return  queryUpdater(query);
    }

    public static boolean deletePictureByID(int picture_id) throws SQLException, ClassNotFoundException{
        String query = "DELETE FROM webgallery.t_picture as P where P.id_picture = '"+picture_id+"'";
        return queryUpdater(query);
    }

    public static ResultSet checkIfPictureWasDeletedCorrectly(int picture_id) throws SQLException, ClassNotFoundException{
        String query = "SELECT * FROM webgallery.t_picture as P LEFT JOIN webgallery.t_like as L ON L.id_picture = P.id_picture LEFT JOIN webgallery.t_picture_statistics as PS ON PS.id_picture =  P.id_picture LEFT JOIN webgallery.t_comment as T ON T.id_picture = P.id_picture where P.id_picture = '"+picture_id+"'";
        return queryExecuter(query);
    }




}
