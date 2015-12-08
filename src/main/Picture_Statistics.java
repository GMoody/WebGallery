package main;

import functions.Checker;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class Picture_Statistics implements Comparable<Picture_Statistics>{

    private int id_picture_statistics;
    private int id_picture;
    private int total_voted;
    private int total_downloads;
    private double picture_rating;

    // General list with pictures statistics
    public static List<Picture_Statistics> picture_statistics = new ArrayList<>();

    public Picture_Statistics(int id_picture_statistics, int id_picture, int total_voted, int total_downloads, double picture_rating) {
        try {
            setId_picture_statistics(id_picture_statistics);
            setId_picture(id_picture);
            setTotal_voted(total_voted);
            setTotal_downloads(total_downloads);
            setPicture_rating(picture_rating);
            picture_statistics.add(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //region Setters
    public void setId_picture_statistics(int id_picture_statistics) throws Exception {
        if (Checker.checkNumber(id_picture_statistics))
            this.id_picture_statistics = id_picture_statistics;
        else throw new Exception("Invalid picture statistics ID!");
    }

    public void setId_picture(int id_picture) throws Exception {
        if (Checker.checkNumber(id_picture))
            this.id_picture = id_picture;
        else throw new Exception("Invalid picture ID!");
    }

    public void setTotal_voted(int total_voted) throws Exception {
        if (Checker.checkNumber(total_voted))
            this.total_voted = total_voted;
        else throw new Exception("Invalid picture total voted!");
    }

    public void setTotal_downloads(int total_downloads) throws Exception {
        if (Checker.checkNumber(total_downloads))
            this.total_downloads = total_downloads;
        else throw new Exception("Invalid picture total downloads!");
    }

    public void setPicture_rating(double picture_rating) throws Exception {
        if (Checker.checkNumber(picture_rating))
            this.picture_rating = picture_rating;
        else throw new Exception("Invalid picture rating!");
    }
    //endregion

    //region Getters
    public int getId_picture_statistics() {
        return id_picture_statistics;
    }

    public int getId_picture() {
        return id_picture;
    }

    public int getTotal_voted() {
        return total_voted;
    }

    public int getTotal_downloads() {
        return total_downloads;
    }

    public double getPicture_rating() {
        return picture_rating;
    }

    public static List<Picture_Statistics> getPicture_statistics() {
        return picture_statistics;
    }
    //endregion

    //region Methods
    public static Picture_Statistics getPicture_statistics (int id_picture){
        for(Picture_Statistics statistics : picture_statistics)
            if(statistics.id_picture == id_picture)
                return statistics;
        return null;
    }

    public static List<Picture_Statistics> sortDownloadsASC(){
        List<Picture_Statistics> temp = picture_statistics;
        Collections.sort(temp);
        return temp;
    }

    public static List<Picture_Statistics> sortRatingASC(){
        List<Picture_Statistics> temp = picture_statistics;
        Collections.sort(temp, Picture_Statistics.RatingComparator);
        return temp;
    }

    @Override
    public int compareTo(Picture_Statistics o) {
        return Integer.compare(this.getTotal_downloads(), o.getTotal_downloads());
    }

    public static Comparator<Picture_Statistics> RatingComparator = (o1, o2) -> Double.compare(o1.getPicture_rating(), o2.getPicture_rating());

    //endregion
}
