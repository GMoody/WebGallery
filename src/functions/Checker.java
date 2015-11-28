package functions;

public class Checker {

    public static boolean checkString(String string) {
        return (string != null && !string.isEmpty());
    }

    public static boolean checkNumber(int number) {
        return number > 0;
    }

    public static boolean checkNumber(double number) {
        return number > 0;
    }
}
