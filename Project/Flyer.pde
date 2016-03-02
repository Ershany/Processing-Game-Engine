public class Flyer extends Mob {
  
  public Flyer(float x, float y, Tilemap map) {
    super(x, y, map);
  }
  
  public void init() {
    // Statistics
    health = 150; 
    xSpeed = 5f;
    ySpeed = 5f;
    width = 32;
    height = 32;
    worth = 25;
  }
  
  public void update() {
    super.checkSlow();
    move();  
    checkLife();
  }
  
  public void render(int xOffset, int yOffset) {
    if(shouldShow) {
      fill(10, 211, 3);
      ellipse(x - xOffset + 8, y - yOffset + 8, width - 1, height - 1);
    }
  }
  
  
  private void move() {
    // Move towards current goal ignoring towers
    x -= xSpeed;
      
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