package main;

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
            e.printStackTrace();
            return;
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
        if(id_category > 0)
            this.id_category = id_category;
        else throw new Exception("Invalid category ID");
    }

    public void setCategory(String category) throws Exception {
        if(category != null && !category.isEmpty())
            this.category = category;
        else throw new Exception("Invalid category!");
    }
    //endregion

    //region Methods
    public static Category getCategoryInfo(int id_category){
        for(Category category : categories)
            if(category.id_category == id_category)
                return category;
        return null;
    }
    //endregion
}
