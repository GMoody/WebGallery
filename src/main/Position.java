package main;

import functions.Checker;
import java.util.ArrayList;
import java.util.List;

public class Position {

    private int id_position;
    private String position;

    // General list with positions
    public static List<Position> positions = new ArrayList<>();

    public Position(int id_position, String position) throws Exception {
        try {
            setId_position(id_position);
            setPosition(position);
            positions.add(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //region Setters
    public void setId_position(int id_position) throws Exception {
        if(Checker.checkNumber(id_position))
            this.id_position = id_position;
        else throw new Exception("Invalid position ID");
    }

    public void setPosition(String position) throws Exception {
        if(Checker.checkString(position))
            this.position = position;
        else throw new Exception("Invalid position!");
    }
    //endregion

    //region Getters
    public int getId_position() {
        return id_position;
    }

    public String getPosition() {
        return position;
    }

    public static List<Position> getPositions() {
        return positions;
    }
    //endregion

    //region Methods
    public static Position getPositionInfo (int id_position){
        for(Position position : positions)
            if(position.id_position == id_position)
                return position;
        return null;
    }

    //endregion
}
