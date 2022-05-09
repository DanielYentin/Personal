public class Square {
    int r, c;
  
    private char val;
    private boolean isCovered;
    private boolean isFlagged;
    
    public Square(int r, int c, char val) {
        this.r = r; this.c = c;
      
        this.val = val;
        this.isCovered = true;
        this.isFlagged = false;
    }
    
    public void setVal(char val) {this.val = val;}
    public char getVal() {return this.val;}
    
    public void setCovered(boolean isCovered) {this.isCovered = isCovered;}
    public boolean getCovered() {return this.isCovered;}
    
    public void setFlagged(boolean isFlagged) {this.isFlagged = isFlagged;}
    public boolean getFlagged() {return this.isFlagged;}
    

    
    
}
