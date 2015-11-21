package functions;

import java.sql.*;

public class Connections {

    public Connection getConnection() throws SQLException {

        String username, password;
        username = password = "t131568";
        String servername = "dev.vk.edu.ee";
        String database = "db_Kulakov";

        try (Connection conn = DriverManager.getConnection("jdbc:postgresql://" + servername + "/" + database, username, password)) {
            return conn;
        } catch (Exception e) {
            System.out.println("Connection with database failed!");
            e.printStackTrace();
            return null;
        }
    }

    public static ResultSet getUsers() throws SQLException {
        String sql = "SELECT * FROM webgallery.t_user";
        return new Connections().getConnection().createStatement().executeQuery(sql);
    }

    public static boolean addUser(String user_name, String user_fname, String user_lname, String user_email, String user_pwd) throws SQLException {
        String sql = "INSERT INTO webgallery.t_user (id_position, user_name, first_name, last_name, email, password) " +
                     "VALUES (1, '" + user_name + "', '" + user_fname +"', '" + user_lname + "', '" + user_email + "', '" + user_pwd + "')";
        return new Connections().getConnection().createStatement().executeUpdate(sql) > 0;
    }
}
