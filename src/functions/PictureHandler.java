package functions;

import main.Category;
import main.Picture;
import main.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PictureHandler {

    public static List<Picture> getMainPictures() {
        // Метод, который берёт картинки из БД, но добавляет в общий лист с картинками только те, которых ещё так нет.
        try {

            ResultSet rs = Connections.getAllPictures();

            if (rs != null) {
                while (rs.next()) {
                    if (Picture.getPictureInfo(rs.getInt(1)) == null) {
                        Picture temp = new Picture(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getString(5), rs.getString(6));
                        Category.checkCategoryInList(rs.getInt(2)); // Метод проверяющий наличие категории, иначе добавляет в лист.
                        User.checkUserInList(rs.getInt(3));
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
