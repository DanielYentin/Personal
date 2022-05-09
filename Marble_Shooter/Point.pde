public class Point {
  float x, y;

  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Point(String strPoint) {
    String[] strPointSplit = strPoint.split(",");
    float x = float(strPointSplit[0]);
    float y = float(strPointSplit[1]);
    //this(x, y);
  }
}
