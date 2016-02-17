public class BasicTower extends Tower {
  
  public BasicTower(Tile tile, PImage image) {
    super(tile);
    this.image = image;
  }
  
  public void init() {
    cost = 100;
    damage = 5f;
    attackSpeed = 45;
  }
  
  public void update() {
    
  }
  
  public void render(int xOffset, int yOffset) {
    super.renderTower(xOffset, yOffset);
  }
  
}