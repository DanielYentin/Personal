import java.util.*;

Square[][] maze; int SQUARESIZE = 50;
Square start, finish;
ArrayList<Square> shortestPath;
    
void setup() {
    size(500,500);
    this.maze = new Square[height/SQUARESIZE][width/SQUARESIZE];
    for (int r = 0; r < maze.length; r++) {
        for (int c = 0; c < maze[r].length; c++) {
            maze[r][c] = new Square(r,c);
        }
    }
    this.start = maze[0][0]; this.finish = maze[maze.length-1][maze[maze.length-1].length-1];
    this.shortestPath = new ArrayList<Square>();
}

void reset() {
    for (int r = 0; r < maze.length; r++) {
        for (int c = 0; c < maze[r].length; c++) {
            boolean old = maze[r][c].isObstacle;
            maze[r][c] = new Square(r,c);
            maze[r][c].isObstacle = old;
            
        }
    }
}

boolean inBounds(int r, int c) {
    return (0 <= r && r < maze.length) && (0 <= c && c < maze[r].length);
}

/**
* @param A valid square
* @return an array of Squares (0-8) who neighbor the square and are not an obstacle
*/
Square[] getNeighbors(Square square) {
    Square[] neighbors = new Square[8];
    int size = 0;
    for (int r = square.r-1; r <= square.r+1; r++) {
        for (int c = square.c-1; c <= square.c+1; c++) {
            if (inBounds(r,c) && (r!=square.r || c!=square.c) && !square.isObstacle) {
                neighbors[size] = maze[r][c]; size++;
            } 
        }
    } return Arrays.copyOfRange(neighbors, 0, size);
}

int dist(Square square1, Square square2) {
    return int(10*dist(square1.c,square1.r, square2.c,square2.r));
}

ArrayList<Square> getShortestPath() {
    ArrayList<Square> path = new ArrayList<Square>();
    Square current = finish;
    while(current.cameFrom != null) {
        path.add(0, current.cameFrom);
        current = current.cameFrom;
    } return path;
}

/**
  returns length of shortest path from start to finish
  if no path exists returns -1
*/
int aStar() {
    PriorityQueue<Square> possible = new PriorityQueue<Square>(); possible.add(start);
    start.DFS = 0; start.DFF = dist(start,finish);
    
    while(!possible.isEmpty()) {
        Square current = possible.remove();
        if (current.equals(finish)) {return getShortestPath().size();}
        for (Square neighbor : getNeighbors(current)) {
            int DFS = current.DFS + dist(current, neighbor);
            if (DFS < neighbor.DFS) {
                neighbor.cameFrom = current;
                neighbor.DFS = DFS; neighbor.DFF = dist(neighbor,finish);
                if (!possible.contains(neighbor)) {possible.add(neighbor);}
            } 
        }
    } return -1;
}

void mouseClicked() {
    int r = int(mouseY / SQUARESIZE);
    int c = int(mouseX / SQUARESIZE);
    maze[r][c].isObstacle = !maze[r][c].isObstacle;
}

void draw () {
    background(128);
    
    if (key == 'a') {
        reset(); aStar(); shortestPath = getShortestPath(); if (shortestPath.isEmpty()) {println("No path exists");}
    }
    for (int r = 0; r < maze.length; r++) {
        for (int c = 0; c < maze[r].length; c++) {
              Square square = maze[r][c];
              color COLOR = color(255);
              if (shortestPath.contains(square)) {COLOR = color(0,0,255);}  
              if (square.isObstacle) {COLOR = color(0);}
              fill(COLOR); square(c*SQUARESIZE, r*SQUARESIZE, SQUARESIZE);
        }
    }
    fill(0,255,0); square(0, 0, SQUARESIZE);
    fill(255,0,0); square((maze[maze.length-1].length-1)*SQUARESIZE, (maze.length-1)*SQUARESIZE, SQUARESIZE);
}
