package main;

import java.util.ArrayList;
import java.util.List;

public class User_Statistics {

    int id_user_statistics;
    int id_user;
    int total_voted;
    double user_rating;

    static List<User_Statistics> user_statistics = new ArrayList<>();

    public User_Statistics(int id_user_statistics, int id_user, int total_voted, double user_rating) {
        try {
            setId_user_statistics(id_user_statistics);
            setId_user(id_user);
            setTotal_voted(total_voted);
            setUser_rating(user_rating);
            user_statistics.add(this);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

    //region Setters
    public void setId_user_statistics(int id_user_statistics) throws Exception {
        if (checkNumber(id_user_statistics))
            this.id_user_statistics = id_user_statistics;
        else throw new Exception("Invalid user statistics ID!");
    }

    public void setId_user(int id_user) throws Exception {
        if (checkNumber(id_user))
            this.id_user = id_user;
        else throw new Exception("Invalid user ID!");
    }

    public void setTotal_voted(int total_voted) throws Exception {
        if (checkNumber(total_voted))
            this.total_voted = total_voted;
        else throw new Exception("Invalid user total voted!");
    }

    public void setUser_rating(double user_rating) throws Exception {
        if (checkNumber(user_rating))
            this.user_rating = user_rating;
        else throw new Exception("Invalid user rating!");
    }
    //endregion

    //region Getters
    public int getId_user_statistics() {
        return id_user_statistics;
    }

    public int getId_user() {
        return id_user;
    }

    public int getTotal_voted() {
        return total_voted;
    }

    public double getUser_rating() {
        return user_rating;
    }

    public static List<User_Statistics> getUser_statistics() {
        return user_statistics;
    }
    //endregion

    private boolean checkNumber(int number) {
        return number > 0;
    }

    private boolean checkNumber(double number) {
        return number > 0;
    }
}
