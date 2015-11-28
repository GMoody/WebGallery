package main;

import functions.Checker;
import functions.Connections;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Category {

    private int id_category;
    private String category;

    // General list with categories
    public static List<Category> categories = new ArrayList<>();

    public Category(int id_category, String category) throws Exception {
        try {
            setId_category(id_category);
            setCategory(category);
            categories.add(this);
        } catch (Exception e) {
            System.out.println("Category Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    //region Getters
    public int getId_category() {
        return id_category;
    }

    public String getCategory() {
        return category;
    }

    public static List<Category> getCategories() {
        return categories;
    }
    //endregion

    //region Setters
    public void setId_category(int id_category) throws Exception {
        if (Checker.checkNumber(id_category))
            this.id_category = id_category;
        else throw new Exception("Invalid category ID");
    }

    public void setCategory(String category) throws Exception {
        if (Checker.checkString(category))
            this.category = category;
        else throw new Exception("Invalid category!");
    }
    //endregion

    //region Methods
    public static Category getCategoryInfo(int id_category) {
        for (Category category : categories)
            if (category.id_category == id_category)
                return category;
        return null;
    }

    public static void checkCategoryInList(int id_category) {
        // Метод проверяющий наличие категории, иначе добавляет в лист.
        try {
            ResultSet rs = Connections.getCategoryInfo(id_category);
            if(rs.next()){
                if(getCategoryInfo(rs.getInt(1)) == null) {
                    Category temp = new Category(id_category, rs.getString(2));
                    rs.close();
                }
            }
        } catch (Exception e) {
            System.out.println("Category Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    //endregion
}
