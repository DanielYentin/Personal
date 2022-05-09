import java.util.*;

Square[][] minefield;

// Board constants
int ROWS, COLS;
int SQUARESIZE;
int BOMBS, FLAGS;
boolean WON, LOST;

// Value constants
char BOMB = 'B';
char FLAG = 'F';

// Color constants
color COVEREDCOLOR = color(100);
color UNCOVEREDCOLOR = color(128);
color[] NUMCOLORS = {
   color(0,0,255),     // 1 : Blue
   color(0,255,0),     // 2 : Green
   color(255,0,0),     // 3 : Red
   color(0,0,55),      // 4 : Dark Blue 
   color(55,0,0),      // 5 : Dark Red
   color(100,65,0),    // 6 : Orange
   color(100,75,80),   // 7 : Pink
   color(255,255,0),   // 8 : Yellow
}; 

//--------------------------------------------------------------------------------

boolean inBounds(int r, int c) {
    return (0 <= r && r < minefield.length) && (0 <= c && c < minefield[r].length);
}

/**
* @param A valid square
* @return an array of Squares (0-8) who neighbor the square and are not null
*/
Square[] getNeighbors(Square square) {
    Square[] neighbors = new Square[8];
    int size = 0;
    for (int r = square.r-1; r <= square.r+1; r++) {
        for (int c = square.c-1; c <= square.c+1; c++) {
            if (inBounds(r,c) && (r!=square.r || c!=square.c) && minefield[r][c] != null) {
                neighbors[size] = minefield[r][c]; size++;
            } 
        }
    } return Arrays.copyOfRange(neighbors, 0, size);
}

void initlizeBombs(int bombs) {
    int placed = 0;
    while (placed < bombs) {
         int r = int(random(0, ROWS));
         int c = int(random(0, COLS));
         
         if (minefield[r][c] == null) { // if empty
             minefield[r][c] = new Square(r, c, BOMB);
             placed++;
         }
    }
}

void placeNums() {
    for (int r = 0; r < minefield.length; r++) {
        for (int c = 0; c < minefield[r].length; c++) {
             if (minefield[r][c] == null) { // if empty
                 minefield[r][c] = new Square(r, c, '0');
                 Square square = minefield[r][c];
                 int val = 0;
                 Square[] neighbors = getNeighbors(square);
                 for (Square neighbor : neighbors) {
                     if (neighbor.getVal() == BOMB) { // if exists and is a bomb
                         val++;
                     }
                 }  
                 square.setVal(char('0' + val));
             }
        }
    }
}

void setup() {
  size(1000, 1000);
  this.SQUARESIZE = 50;
  this.ROWS = (height-100)/SQUARESIZE; this.COLS = width/SQUARESIZE; // leave a 100px tab on the bottom for game info
  this.BOMBS = 20+int(sqrt(ROWS*COLS)); this.FLAGS = BOMBS;
  this.WON = false; this.LOST = false;
  this.minefield = new Square[ROWS][COLS];
  initlizeBombs(BOMBS); placeNums();
          

  while (true) { // uncover one empty square to start with
         int r = int(random(0, ROWS));
         int c = int(random(0, COLS));
         Square square = minefield[r][c];
         if (square.getVal() == '0') {
             uncoverAllConnectedZeros(square); break;
         }
    }
}

void uncoverAllConnectedZeros(Square start) { // for mass uncovering all connected zeros
    Queue<Square> queue = new ArrayDeque<Square>();
    queue.add(start); start.setCovered(false);
    
    while (!queue.isEmpty()) { //<>//
        Square square = queue.remove();
        Square[] neighbors = getNeighbors(square);
        for (Square neighbor : neighbors) { //<>//
            if (neighbor.getCovered() && neighbor.getVal() == '0') {
                queue.add(neighbor);
            } neighbor.setCovered(false);
        }
    }
}

void mouseClicked() {
    if (WON || LOST) {return;} // freeze game if won or lost
    int r = int(mouseY / SQUARESIZE);
    int c = int(mouseX / SQUARESIZE);
    if (r >= ROWS) {return;} // if clicked outside of field;
    Square square = minefield[r][c];
    char val = square.val;
    if (mouseButton == LEFT) { // uncover
        if (square.getCovered() && !square.isFlagged) {
            square.setCovered(false);
            if (val == BOMB) {LOST = true;}
            if (val == '0') {uncoverAllConnectedZeros(square);}
        } 
    } else if (mouseButton == CENTER && ('0' <= val && val <= '8')) { // uncover group
        Square[] neighbors = getNeighbors(square);
        int flagged = 0;
        for (Square neighbor : neighbors) {
            if (neighbor.isFlagged) {flagged++;}
        } if (flagged == val-'0') {
            for (Square neighbor : neighbors) {
                  if (!neighbor.isFlagged) {
                      neighbor.setCovered(false);
                      if (neighbor.getVal() == '0') {uncoverAllConnectedZeros(neighbor);}
                      else if (neighbor.getVal() == BOMB) {LOST = true; return;}
                      
                  }
            }
        }
    } else if (mouseButton == RIGHT) { // flag
        if (square.getCovered() && !square.isFlagged) {
            square.setFlagged(true); FLAGS--;
        } else if (square.getCovered() && square.isFlagged) {
            square.setFlagged(false); FLAGS++;
        } 
    }
}

/**
  checks for win by seeing if all non bomb squares have been uncovered
*/
void checkWin() {
    for (int r = 0; r < minefield.length; r++) {
        for (int c = 0; c < minefield[r].length; c++) {
            Square square = minefield[r][c];
            if (square.val != BOMB && square.getCovered()) {return;} 
        }
    } WON = true;
}

/**
  draws the square, colored according to getCovered(), and draws the value, colored according to getVal()
  @param square to draw
   
*/
void drawSquare(Square square) {
    //place and color square accordingly
    color squareColor = COVEREDCOLOR;
    if (!square.getCovered()) {squareColor = UNCOVEREDCOLOR;}
    fill(squareColor); square(square.c*SQUARESIZE, square.r*SQUARESIZE, SQUARESIZE); 
    char val = ' '; color valColor = color(0,255);
    if (square.getCovered() && square.isFlagged) {valColor = color(255,0,0); val = FLAG;}
    else if (!square.getCovered()) {
        if (square.getVal() == BOMB) {valColor = color(255,0,0); val = BOMB;}
        else if (square.getVal() == '0') {}
        else {valColor = color(NUMCOLORS[square.val-'1']); val = square.val;} 
    }
    
    // place and color val accordingly (0's are invisible by defualt)
    fill(valColor);
    textSize(18); text(val, square.c*SQUARESIZE + SQUARESIZE/2 - 5, square.r*SQUARESIZE + SQUARESIZE/2 + 5);
}

void draw() {
    background(128); checkWin();
    if (WON) {fill(0,255,0); text("YOU WON, GJ", width/2 - 70, height-40);}
    else if (LOST) {fill(255,0,0); text("YOU LOST LMAO", width/2 - 70, height-40);}
    for (int r = 0; r < minefield.length; r++) {
        for (int c = 0; c < minefield[r].length; c++) {
            Square square = minefield[r][c]; drawSquare(square);
            fill(255,0,0); text("Flags remaining: " + FLAGS, 0, height-70);
        }
    }
}
