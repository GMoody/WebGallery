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
        String sql = "SELECT * FROM webgallery.t_picture"; // Here we need sorted by date pictures
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
}
