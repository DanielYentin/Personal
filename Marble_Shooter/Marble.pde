public class Marble {
  float r, x, y, dx, dy;
  color c;

  public Marble(float x, float y, float dx, float dy, color c) {
    this.r = 10;

    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;

    this.c = c;
  }

  void update() {
    x += dx;
    y += dy;
  }

  void display() {
    fill(c);
    circle(x, y, r);
  }
}
