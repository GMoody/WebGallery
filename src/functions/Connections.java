package functions;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

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
            return null;
        }
    }
}
