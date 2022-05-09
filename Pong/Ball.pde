public class Ball {
    float x, y, r;
    float dx, dy;
    
    public Ball(float x, float y) {
        this.x = x; this.y = y; this.r = 5;
        dx = 7; dy = 3; 
    }
    
    public void update() {
        x += dx; y += dy;
        if (x - r <= 0) {x = r; dx *= -  1;}
        if (x + r >= width) {x = width - r; dx *= -  1;}
        if (y - r <= 0) {y = r; dy *= -  1;}
        if (y + r >= height) {y = height - r; dy *= -  1;}
    }
    
    public void display() {
        circle(x, y, 10);
    }
}
