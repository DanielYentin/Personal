public class Square implements Comparable<Square>{
    int r, c;
    Square cameFrom;
    int DFS, DFF;
    boolean isObstacle;
    
    public Square(int r, int c) {
        this.r = r; this.c = c;
        this.cameFrom = null;
        this.DFS = Integer.MAX_VALUE; this.DFF = Integer.MAX_VALUE;
        this.isObstacle = false;
    }
    
    public int score() {
        return DFS+DFF;
    }
    
    public int compareTo(Square square) {
        return score() - square.score();
    }
}
