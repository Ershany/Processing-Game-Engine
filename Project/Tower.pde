public abstract class Tower {
  
  public PImage image;
  protected int cost;
  protected float damage;
  protected int attackSpeed;
  protected Rectangle range;
  
  protected Tile tile;
  
  public Tower(Tile tile) {
    this.tile = tile;
    
    init();
  }
  
  public abstract void init();
  
  public abstract void update();
  public abstract void render(int xOffset, int yOffset);
  
  public void renderTower(int xOffset, int yOffset) {
    if(image != null) {
      image(image, (tile.getX() << 5) - xOffset, (tile.getY() << 5) - yOffset);
    }
  }
  
  
  // Setters
  public void setTile(Tile tile) {
    this.tile = tile;  
  }
  
  
  // Getters
  public Tile getTile() {
    return tile;  
  }
  public int getCost() {
    return cost;  
  }
  public float getDamage() {
    return damage;  
  }
  public float getAttackSpeed() {
    return attackSpeed;  
  }
  public Rectangle getRange() {
    return range;  
  }
  
}