package functions;

import main.Category;
import main.Picture;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class PictureHandler {

    public static List<Picture> getMainPictures(){
        // Метод, который берёт картинки из БД, но добавляет в общий лист с картинками только те, которых ещё так нет.
        try {

            ResultSet rs = Connections.getAllPictures();

            if(rs != null){
                if(Picture.pictures.size() != 0){
                    while(rs.next()){
                        Picture temp = new Picture(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getString(5), rs.getString(6));
                        Category.checkCategoryInList(rs.getInt(2)); // Метод проверяющий наличие категории, иначе добавляет в лист.
                        // Необходима ещё куча методов, которые обрабатывают также пользовательскую информацию и статистику
                    }
                }
                else{
                    while(rs.next()) {
                        for (Picture picture : Picture.pictures) {
                            if (picture.getId_picture() != rs.getInt(1)) {
                                Picture temp = new Picture(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDate(4), rs.getString(5), rs.getString(6));
                                Category.checkCategoryInList(rs.getInt(2)); // Метод проверяющий наличие категории, иначе добавляет в лист.
                                // Необходима ещё куча методов, которые обрабатывают также пользовательскую информацию и статистику
                            }
                        }
                    }
                }
                rs.close();
                return Picture.pictures;
            }
            else return null;

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Picture Error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
