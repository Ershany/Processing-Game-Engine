public class InterchangeableFloorTile extends Tile {
  
  public InterchangeableFloorTile(int x, int y, PImage image) {
    super(x, y, image);
  }
  
  public void init() {
    projectileSolid = false;
    walkSolid = false;
  }
  
  public void update() {
    
  }
  
  public void render(int xOffset, int yOffset) {
    image(image, (x << 5) - xOffset, (y << 5) - yOffset);
  }
  
}