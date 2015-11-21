package main;

public class Position {

    int id_position;
    String position;

    public Position(int id_position, String position) throws Exception {
        try {
            setId_position(id_position);
            setPosition(position);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

    public void setId_position(int id_position) throws Exception {
        if(id_position > 0)
            this.id_position = id_position;
        else throw new Exception("Invalid position ID");
    }

    public void setPosition(String position) throws Exception {
        if(position != null && !position.isEmpty())
            this.position = position;
        else throw new Exception("Invalid position!");
    }
}
