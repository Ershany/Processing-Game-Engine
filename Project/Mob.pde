import java.awt.Rectangle;

public abstract class Mob extends Entity {
  
  protected Rectangle hitbox;
  protected Tilemap map;
  protected int health;
  protected float xSpeed, ySpeed;
  protected int width, height;
  public boolean stunned;
  public boolean shouldShow = true;
  protected int worth;
  
  public Mob(float x, float y, Tilemap map) {
    super(x, y);
    this.map = map;
    
    init();
  }
  
  protected void moveX(float xChange) {
    if(map.getTile((int)(x + xChange), (int)y).getWalkSolid()) {
      return;  
    }
    
    // Change player position
    x += xChange;  
  }
  protected void moveY(float yChange) {  
    if(map.getTile((int)x, (int)(y + yChange)).getWalkSolid()) {
      return;  
    }
    
    // Change player position
    y += yChange;
  }
  protected void updateHitbox() {
    hitbox.x = (int)x;
    hitbox.y = (int)y;
  }
  
  public abstract void init();
  public abstract void update();
  public abstract void render(int xOffset, int yOffset);
  
  public void hit(int damage) {
    health -= damage;  
  }
  
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