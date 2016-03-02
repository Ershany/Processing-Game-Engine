public class Speeder extends Mob {
  
  private Stack<Node> pathing;
  private Node currentGoal;
  
  public Speeder(float x, float y, Tilemap map, Stack<Node> pathing) {
    super(x, y, map);
    this.pathing = pathing;
    currentGoal = pathing.pop();
  }
  
  public void init() {
    // Statistics
    health = 150; 
    xSpeed = 5.8f;
    ySpeed = 5.8f;
    width = 16;
    height = 16;
    worth = 20;
  }
  
  public void update() {
    super.checkSlow();
    super.checkDot();
    move();  
    checkLife();
  }
  
  public void render(int xOffset, int yOffset) {
    if(shouldShow) {
      fill(255, 192, 203);
      rect(x - xOffset + 8, y - yOffset + 8, width - 1, height - 1);
    }
  }
  
  
  private void move() {
    // Move towards current goal
    if((currentGoal.x << 5) > x)
      x += xSpeed;
    if((currentGoal.x) << 5 < x)
      x -= xSpeed;
    if((currentGoal.y << 5) > y)
      y += ySpeed;
    if((currentGoal.y << 5) < y)
      y -= ySpeed;
      
    // Check if the goal was basically reached
    if(Math.abs((currentGoal.x << 5) - x) < 6 && Math.abs((currentGoal.y << 5) - y) < 6)
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