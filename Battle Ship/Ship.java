public class Ship {
    private int length; // >= 2
    private string direction; // "left-right" || "up-down"
    private int[] pos;

    public Ship(int length;) {
        this.size = size;
        pos = new int[2];
    }

    public void place(String coords, String direction) {
        String error = "";
        if (coords.length() != 2) {
            // error not a valid coordinate point, missing one or more values
            error += "Error not a valid coordinate point, missing letter and/or number!\n";
        }
        char x = coords.charAt(0);
        if (!(x >= 65 && x <= 65 + size - 1)) {
            // error letter is not a capital letter in the range A - (chr)65+size
            error += "Error letter" + x + ""
        }

        char y = coords.charAt(1);
        if (!(y >= 48 && y <= 48 + size - 1)) {
            // error number not in range 0 - 0+size - 1
        }

        if (!(direction.equals("left-right") || direction.equals("up-down")) {
            // error direction not either "left-right" or "up-down"
        }
        pos[0] = x - 65; pos[1] = y - 48;

}
