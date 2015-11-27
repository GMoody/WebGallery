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
        Connection conn = new Connections().getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM webgallery.t_user WHERE email = '" + email + "'";
        ResultSet rs = st.executeQuery(sql);
        conn.close();
        return rs;
    }

    public static boolean addUser(String user_name, String user_fname, String user_lname, String user_email, String user_pwd) throws SQLException, ClassNotFoundException {
        Connection conn = new Connections().getConnection();
        Statement st = conn.createStatement();
        String sql = "INSERT INTO webgallery.t_user (id_position, user_name, first_name, last_name, email, password) " +
                "VALUES (1, '" + user_name + "', '" + user_fname + "', '" + user_lname + "', '" + user_email + "', '" + user_pwd + "')";
        return st.executeUpdate(sql) > 0;
    }

    public static ResultSet getAllPictures() throws SQLException, ClassNotFoundException {
        Connection conn = new Connections().getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM webgallery.t_picture"; // Here we need sorted by date pictures
        ResultSet rs = st.executeQuery(sql);
        conn.close();
        return (rs.next()) ? rs : null;
    }

    public static ResultSet getCategoryInfo(int id_category) throws SQLException, ClassNotFoundException {
        Connection conn = new Connections().getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM webgallery.t_category WHERE id_category = " + id_category;
        ResultSet rs = st.executeQuery(sql);
        conn.close();
        return (rs.next()) ? rs : null;
    }
}
