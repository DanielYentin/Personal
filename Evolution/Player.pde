class Player {
    float x, y, h, r;
    int totalLifespan; int lifespan;
    float[] moves;
    public Player(float x, float y, float h, int lifespan) {
        this.x = x;
        this.y = y;
        this.h = h; 
        this.r = 3;
        this.totalLifespan = lifespan;
        this.lifespan = lifespan;
        this.moves = new float[lifespan];
    }
    
    void display() {
        pushMatrix();
        translate(x,y);
        rotate(-radians(h));
        fill(100,100,100);
        triangle(-10,-10,-10,10, 20,0);
        popMatrix();
    }
    
    void update(float hBest) {
      pushMatrix();
        float deltaH = hBest + random(-1,1); 
        h += deltaH; moves[totalLifespan-lifespan] = h; // save move to moves;
        
        float xStep = cos(radians(h)); 
        float yStep = sin(radians(h));
        x += xStep; y -= yStep;
        
        checkCollision();
        lifespan--;
        popMatrix();
        
    }
    
    void checkCollision() {
        if (x <= 0) {x = 0;}
        if (x >= width) {x = width;}
        if (y <= 0) {y = 0;}
        if (y >= height) {y = height;}
    }

    float distToGoal(Goal goal) {
       return dist(x, y, goal.x, goal.y);
    }

    float hitbox() {
        return r;
    }
}
