public class Grunt extends Mob {
  
  public Grunt(float x, float y, Tilemap map) {
    super(x, y, map);
  }
  
  public void init() {
    // Statistics
    health = 10;
    xSpeed = 2f;
    ySpeed = 2f;
    width = 32;
    height = 32;
    worth = 5;
  }
  
  public void update() {
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
    x -= xSpeed;  
  }
  
  private void checkLife() {
    if(health <= 0) {
      shouldRemove = true;
      map.getState().getPlayer().addGold(worth);
    }
  }
}