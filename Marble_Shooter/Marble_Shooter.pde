int level; int health; int marblesRemaining;

Shooter shooter;
ArrayList<Marble> balls;
ArrayList<Point> path; 

public ArrayList<Point> parsePathFromFile() {
    ArrayList<Point> path = new ArrayList<Point>(); 
    String[] file = loadStrings("level"+level+".txt");
    for (String strPoint : file) {
      Point point = new Point(strPoint);
      path.add(point);
    }
    return path;
  }

void setup() {
  size(800, 800);
  
  level = 0;
  health = 50;
  marblesRemaining = 100;
  
  shooter = new Shooter(width/2, height/2);
  
  //path = parsePathFromFile();
  //marbles = new ArrayList<Marble>;
}



void draw() {
  background(255);
  shooter.display();
}
