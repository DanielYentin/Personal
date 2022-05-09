public class Shooter {
  float angle = 0;
  float targetAngle = 0;
  float easing = 0.1;

  
  float x, y, r;
  PShape shooter, body, gun;

  public Shooter(float x, float y) {
    this.x = x;
    this.y = y;

    this.r = 50;
    shooter = createShape(GROUP);
    ellipseMode(RADIUS);
    body = createShape(ELLIPSE, 0, 0, r, r);
    body.setFill(color(165, 42, 42));
    gun = createShape(RECT, x-15, y+r/2, 30, 60);
    gun.setFill(color(0));

    shooter.addChild(body);
    shooter.addChild(gun);
  }

    public void display() {
      // get the angle from the center to the mouse position
      angle = atan2( mouseY - height/2, mouseX - width/2 );
      // check and adjust angle to go from 0 to TWO_PI
      if (angle < 0) angle = TWO_PI + angle;

      // ease rotation
      targetAngle += (angle - targetAngle) * easing;
      pushMatrix();
      translate(x, y);
      rotate(targetAngle);
      shape(shooter, x, y);
      popMatrix();
    }
  }
