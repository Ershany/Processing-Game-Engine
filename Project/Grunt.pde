public class Grunt extends Mob {
  
  private Stack<Node> pathing;
  private Node currentGoal;
  
  public Grunt(float x, float y, Tilemap map, Stack<Node> pathing) {
    super(x, y, map);
    this.pathing = pathing;
    currentGoal = pathing.pop();
  }
  
  public void init() {
    // Statistics
    health = 500; // should be 200
    xSpeed = 2f;
    ySpeed = 2f;
    width = 32;
    height = 32;
    worth = 5;
  }
  
  public void update() {
    super.checkSlow();
    move();  
    checkLife();
  }
  
  public void render(int xOffset, int yOffset) {
    if(shouldShow) {
      fill(0, 0, 255);
      rect(x - xOffset, y - yOffset, width - 1, height - 1);
    }
  }
  
  
  private void move() {
    // Move towards current goal
    if((currentGoal.x << 5) > x)
      x += xSpeed;
    else if((currentGoal.x) << 5 < x)
      x -= xSpeed;
    if((currentGoal.y << 5) > y)
      y += ySpeed;
    else if((currentGoal.y << 5) < y)
      y -= ySpeed;
      
    // Check if the goal was basically reached
    if(Math.abs((currentGoal.x << 5) - x) < 4 && Math.abs((currentGoal.y << 5) - y) < 4)
      currentGoal = pathing.pop();
      
    // Checks to see if the unit is approaching the castle
    if(((int)x >> 5) < 19)
      shouldRemove = true;
  }
  
  private void checkLife() {
    if(health <= 0) {
      shouldRemove = true;
      map.getState().getPlayer().addGold(worth);
    }
  }
}