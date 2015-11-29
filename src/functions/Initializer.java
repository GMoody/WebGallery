package functions;

import main.Category;
import main.Position;
import main.User;

import java.sql.ResultSet;

public class Initializer {
    private static Initializer instance;

    private Initializer() {
        addAllPositions();
        addAllCategories();
        addAllUsers();
    }

    public static Initializer getInstance() {
        if (instance == null)
            instance = new Initializer();
        return instance;
    }

    private void addAllCategories() {
        try {
            ResultSet rs = Connections.getCategories();

            while (rs.next()) {
                Category category = new Category(rs.getInt(1), rs.getString(2));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addAllPositions() {
        try {
            ResultSet rs = Connections.getPositions();

            while (rs.next()) {
                Position position = new Position(rs.getInt(1), rs.getString(2));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addAllUsers() {
        try {
            ResultSet rs = Connections.getUsers();

            while (rs.next()) {
                User user = new User(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
