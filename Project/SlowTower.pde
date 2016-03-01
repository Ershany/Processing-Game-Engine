public class SlowTower extends Tower {
  
  private float projectileSpeed = 12.3f;
  private int projectileSize = 4;
  private RGB colour = new RGB(0, 0, 204);
  
  private float slowingPower = 0.5f;
  private int slowLength = 240;
  
  public SlowTower(Tile tile, GameState state, PImage image) {
    super(tile, state);
    this.image = image;
  }
  
  public void init() {
    cost = 200;
    damage = 10;
    attackSpeed = 140;
    range = 100;
  }
  
  public void update() {
    checkShoot();  
  }
  
  public void render(int xOffset, int yOffset) {
    super.renderTower(xOffset, yOffset);
  }
  
  int current = 0;
  // Checks to see if the tower can attack
  private void checkShoot() {
    current++;
    if(current % attackSpeed == 0) {
      shouldShoot = true;  
    }
    if(shouldShoot) {
      // Perform attacks
      Mob target = null;
      Mob currentTarget = null;
      for(int i = 0; i < state.enemies.size(); i++) {
        currentTarget = state.enemies.get(i);
        if(currentTarget.getHealth() > 0 && Math.abs((tile.x << 5) - currentTarget.getX()) <= range && Math.abs((tile.y << 5) - currentTarget.getY()) <= range) {
          currentTarget.hit(damage);
          currentTarget.slow(slowingPower, slowLength);
          //int lifeTime = (int)((Math.abs((currentTarget.getX() - (tile.x << 5))) + Math.abs((currentTarget.getY() - (tile.y << 5)))) / (projectileSpeed * 1.6));
          state.projectiles.add(new Projectile((tile.x << 5) + 15, (tile.y << 5) + 15, currentTarget.getX() + 15, currentTarget.getY() + 15, projectileSpeed, projectileSize, projectileSize, 200, colour, state.getTilemap()));
          shouldShoot = false;
          current = 0;
          break;
        }
      }
      
      // Reset current
      current = 0;
    }
  }
  
}