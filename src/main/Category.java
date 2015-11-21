package main;

public class Category {

    int id_category;
    String category;

    public Category(int id_category, String category) throws Exception {
        try {
            setId_category(id_category);
            setCategory(category);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

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
}
