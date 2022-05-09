public class Racket {
    float x, y;
    int w, h;
    
    public Racket(float x, float y) {
        this.x = x; this.y = y;
        this.w = 30; this.h = 100;
    }
    
    public void update(float dy) {
        this.y += dy;
        if (y < 0) {y = 0;}
        if (y+h > height) {y = height-h;}
    }
    
    public void display() {
        rect(x, y, w, h);
    }
}
