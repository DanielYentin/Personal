class Goal {
    float x, y, r;
    
    public Goal(float x, float y, float r) {
        this.x = x;
        this.y = y;
        this.r = r;
    }
    
    void display() {
        ellipseMode(CENTER);
        fill(0,255,0);
        ellipse(x, y, r, r);
    }
    
    float hitbox() {
        return r;
    }
}
