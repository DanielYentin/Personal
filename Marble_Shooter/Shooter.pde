public class Shooter {
  PShape shooter, base, body, gun;
  float x, y, r;

  float angle = 0;
  float targetAngle = 0;
  float easing = 0.1;

  int millisOfLastShot = 0;
  int millisSinceLastShot = 0;


  public Shooter(float x, float y) {
    this.x = x;
    this.y = y;

    this.r = 50;
    shooter = createShape(GROUP);
    ellipseMode(RADIUS);
    base = createShape(ELLIPSE, 0, 0, r, r);
    base.setFill(color(165, 42, 42));

    body = createShape(ELLIPSE, 0, 0, r-10, r-10);
    body.setFill(color(0));

    gun = createShape(RECT, -15, 10, 30, 60);
    gun.setFill(color(0));


    shooter.addChild(base);
    shooter.addChild(body);
    shooter.addChild(gun);
  }



  public void update() {
    // get the angle from the center to the mouse position
    angle = atan2(mouseY - x, mouseX - y);
    // check and adjust angle to go from 0 to TWO_PI
    if (angle < 0) angle = TWO_PI + angle;
    // set new target angle
    // shape is offest by 90 for some reason so an offest of 90 is done in opposite direction to compensate
    targetAngle += (angle-targetAngle-HALF_PI);

    // checks if shot exists and if it is still inbounds. If not it gets deleted
    if (shot != null) {
      if (shot.x <= -r || shot.x >= width+r || shot.y <= -r || shot.y >= height+r) {
        shot = null;
      }
    }
  }

  public void display() {
    pushMatrix();
    translate(x, y);
    rotate(targetAngle);
    shape(shooter, 0, 0);
    popMatrix();
  }

  public Marble shoot() {
    float dx = 10*cos(angle);
    float dy = 10*sin(angle);
    color c = NonRandomColorFunction();
    Marble shot = new Marble(x, y, dx, dy, c);
    return shot;
  }
}
