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
    this(x, y);
  }

  public static ArrayList<Point> parsePathFromFile() {
    ArrayList<Point> path = new ArrayList<Point>(); 
    String[] file = loadStrings("level"+level+".txt");
    for (String strPoint : file) {
      Point point = new Point(strPoint);
      path.add(point);
    }
    return path;
  }
}
