public class Grunt extends Mob {
  public Grunt(float x, float y, Tilemap map) {
    super(x, y, map);
  }
  
  public void init() {
    health = 10;
    xSpeed = 2f;
    ySpeed = 2f;
    width = 32;
    height = 32;
  }
  
  public void update() {
    
  }
  
  public void render(int xOffset, int yOffset) {
    if(shouldShow) {
      fill(0, 0, 255);
      rect(x, y, width, height);
    }
  }
}