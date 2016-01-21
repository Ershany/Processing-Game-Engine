import java.awt.Rectangle;

public abstract class Mob extends Entity {
  
  protected Rectangle hitbox;
  protected Tilemap map;
  protected int health;
  protected float xSpeed, ySpeed;
  protected int width, height;
  protected CooldownManager cooldownManager;
  
  public Mob(float x, float y, Tilemap map) {
    super(x, y);
    this.map = map;
  }
  
  public abstract void init();
  public abstract void update();
  public abstract void render(int xOffset, int yOffset);
  
  public abstract void cooldownEvent(String cooldown);
  
  public void checkDead() {
    if(health <= 0) {
      shouldRemove = true;  
    }
  }
  
  // Getters
  public Rectangle getHitbox() {
    return hitbox; 
  }
  public int getHealth() {
    return health; 
  }
  public Tilemap getMap() {
    return map; 
  }
  
}