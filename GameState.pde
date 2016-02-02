import java.util.ArrayList;

public abstract class GameState {
  
  // Graphics for the gamestate
  public Spritesheet tiles = new Spritesheet("tiles.png", 32, 32);
  public Sprite castleFloor = new Sprite(0, 0, tiles);
  public Sprite water = new Sprite(1, 0, tiles);
  public Sprite grass = new Sprite(2, 0, tiles);
  public Sprite sand = new Sprite(3, 0, tiles);
  
  // Lists to update and render
  protected List<Particle> particleList = new ArrayList<Particle>();
  
  protected GameStateManager gsm;
  
  public GameState(GameStateManager gsm) {
    this.gsm = gsm;
    
    init();
  }
  
  public abstract void init();
  public abstract void update();
  public abstract void render();
  
  public abstract void keyPressed(String key);
  public abstract void keyReleased(String key);
  
  // getters
  public GameStateManager getGSM() {
    return gsm; 
  }
  
  // setters
  public void addParticle(Particle p) {
    particleList.add(p); 
  }
}