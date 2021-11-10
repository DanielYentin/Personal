public class Board {
    private int size;
    private int[][] board;
    private int[] ships;
    /**
     * Make board of size: size
     * Make a list of ships of size: size
     * @param size
     */
    public Board(int size) {
        this.size = size;
        board = int[size][size];
        ships = int[size];
        for (int i = 0; i < size; i++) {
            ships[i] = new ship(i+2);
        }
    }

    /**
     *  <li>1. Replaces all occurences of a 0 with an "*" aka blank or unknown.</li>
     *  <li>2. Replaces all occurences of a -1 with a "O" aka miss.</li>
     *  <li>3. Replaces all occurences of a 1 with a "X" aka hit.</li>
     *  <li>4. Doesn't replace any number x >= 2 aka type of ship.</li>
     *  @return Returns a string representation of the board with axies.
    */
    public String toString() {
        String str2DArray = "";
        String strArray = "";

        // X axis with letters
        strArray = "    ";
        for (int i = 0; i < size; i++) {
            strArray += (char)(65 + i);
            if (i != size - 1) {
                strArray += "  ";
            }
            else {
                strArray += "\n";
            }
        }
        str2DArray += strArray;

        // Seperation line between X-axis and board
        strArray = "    ";
        for (int i = 0; i < size; i++) {
            if (i != size - 1) {
                strArray += "---";
            }
            else {
                strArray += "-\n";
            }
        }
        str2DArray += strArray;

        // Board
        strArray = "";
        for (int i = 0; i < size; i++) {
            strArray = (i + 1) + " | ";
            for (int j = 0; j < size; j++) {
                // Replaces int values with battle ship equivlents. See java doc of toString for conversions
                if (board[i][j] == 0) {
                    strArray += "*";
                }
                else if (board[i][j] == -1) {
                    strArray += "O";
                }
                else if (board[i][j] == 1) {
                    strArray += "X";
                }
                else {
                    strArray += board[i][j];
                }
                if (j != size - 1) {
                    strArray += "  ";
                }
            }
            str2DArray += strArray;
            if (i != size - 1) {
                str2DArray += "\n";
            }
        }
        return str2DArray;
    }

    /**
     * @return size of board
    */
    public int size() {
        return size;
    }

    /**
     * @param i
     * @param j
     * @return value at row i, collumn j of board.
     */
    public int get(int i, int j) {
        return board[i][j];
    }

    /**
     * Sets the item at row i, collumn j of board to value.
     * @param i
     * @param j
     * @param value
     * @return value.
     */
    public int set(int i, int j, int value) {
        board[i][j] = value;
        return value;
    }
}
