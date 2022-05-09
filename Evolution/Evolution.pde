ArrayList<Player> players = new ArrayList<Player>();
Goal goal;
Player bestPlayer; boolean won;
int generation = 0;


void setup() {
    noLoop();
    size(1000, 1000);
    goal = new Goal(random(width), random(height), 10); 
    bestPlayer = new Player(width/2, height/2, 0, 100); won = false;
    generation(12, 100);
}

void reset() {
  players.clear();
  won = false;
  setup();
}

void spawn(int total, int lifespan) {
  players.clear();
  for (int p = 0; p < total; p++) {
    Player player;
    if (generation == 0) {player = new Player(width/2, height/2, p * (360/total), lifespan);}
    else {player = new Player(width/2, height/2, bestPlayer.moves[0], 50);}
    players.add(player);
  } 
} 

void generation(int total, int lifespan) {
  spawn(total, lifespan);
  while(players.get(0).lifespan != 0) {
    //background(200);
    println("delay");
    for (Player player : players) {
      player.display();
      println("display");
      if (lifespan < bestPlayer.moves.length) {player.update(bestPlayer.moves[lifespan-player.lifespan]);} // if still within best moves
      else {player.update(0);} // if past best moves, pass defualt of 0;
      if (dist(player.x, player.y, goal.x, goal.y) < player.hitbox() + goal.hitbox()) { // check for win
           bestPlayer = player;
           won = true;
      } 
    } 
  } 
  for (Player player : players) { // update best player
      if (player.distToGoal(goal) < bestPlayer.distToGoal(goal)) {bestPlayer = player;} 
  } generation++; println(generation);
  return;
}


//void draw() {
//  background(200);
//  text(bestPlayer.distToGoal(goal),20,20);
//  goal.display();
//  for (Player player : players) {
//      player.display();
//  }
//}
