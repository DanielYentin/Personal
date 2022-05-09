Ball ball;
Racket left, right;
float speed;

void setup() {
    size(500,500);
    ball = new Ball(width/2, height/2);
    left = new Racket(0, height/2); right = new Racket(width-30, height/2);
    this.speed = 10;
}

void keyPressed() {
    if (key == 'w') {left.update(-speed);}
    if (key == 's') {left.update(speed);}
    if (key == UP) {right.update(-speed);}
    if (key == DOWN) {right.update(speed);}
}

void draw() {
    background(128);
    ball.update(); ball.display();
    left.display(); right.display();
}
