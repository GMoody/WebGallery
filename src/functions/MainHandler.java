package functions;

import main.Picture;
import main.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class MainHandler {

    public static List<Picture> getMainPictures() {
        // Метод, который берёт картинки из БД, но добавляет в общий лист с картинками только те, которых ещё так нет.
        try {
            Initializer.getInstance(); // Создаём "Singleton": выкачиваем все позиции пользователей, все категории картинок, добавляем всех пользователей.
            ResultSet rs = Connections.getAllPictures();

            if (rs != null) {
                while (rs.next()) {
                    if (Picture.getPictureInfo(rs.getInt(1)) == null) { // Срабатывает, только если поступают новые картинки.
                        Picture temp = new Picture(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getString(5), rs.getString(6));
                        User.addPictureToUser(rs.getInt(3), temp);
                    }
                    // Необходима ещё куча методов, которые обрабатывают также пользовательскую информацию и статистику
                }
                rs.close();
                return Picture.pictures;
            } else return null;

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Picture Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
