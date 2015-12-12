package functions;

import main.Category;
import main.Picture;
import main.Picture_Statistics;
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

    public static byte uploadPicture(String user_name, String category, String description, String picture_url){
        if(User.getUserInfoByUserName(user_name) != null) {
            int upl_user_id = User.getUserInfoByUserName(user_name).getId_user();
            if(Category.getCategoryInfo(category) != null){
                int id_category = Category.getCategoryInfo(category).getId_category();

                try {
                    ResultSet rs = Connections.addPicture(id_category, upl_user_id, description, picture_url);

                    if(rs.next()) {
                        Picture temp = new Picture(rs.getInt(1), id_category, upl_user_id, rs.getDate(4), description, picture_url);
                        User.addPictureToUser(upl_user_id, temp);
                        Connections.addPictureStatistics(rs.getInt(1));
                        ResultSet statistics = Connections.getPictureStatistics(rs.getInt(1));

                        if(statistics.next()){
                            Picture_Statistics ps = new Picture_Statistics(statistics.getInt(1), statistics.getInt(2), statistics.getInt(3), statistics.getInt(4), statistics.getInt(5));
                            Picture_Statistics.getPicture_statistics();
                            statistics.close();
                        }

                        rs.close();
                        return 1;   // Success
                    }else return 0; // RS error
                } catch (SQLException | ClassNotFoundException | NullPointerException e) {
                    e.printStackTrace();
                    return -1;  // Exception
                }
            }else return -1;    // Category problem
        }else return -2;            // User problem
    }
}
