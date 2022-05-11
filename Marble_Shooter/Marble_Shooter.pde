int level; 
int health; 

Shooter shooter;
Marble shot;

ArrayList<Marble> marbles;
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

  shooter = new Shooter(width/2, height/2);

  //path = parsePathFromFile();
  marbles = new ArrayList<Marble>();
}

// needs better name;
public color NonRandomColorFunction() { 
  return color(255, 0, 0);
}

public void mousePressed() {
  if (shot == null) {//(shooter.millisSinceLastShot > 1000) {
    shot = shooter.shoot();
  }
}

void update() {
  if (health == 0) {
  }
  
  
}

void draw() {
  background(255);

  shooter.update();
  shooter.display();

  if (shot != null) {
    shot.update();
    shot.display();
  }

  for (Marble marble : marbles) {
    marble.update();
    marble.display();
  }

  update();
}
