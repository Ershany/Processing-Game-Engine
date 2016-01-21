import java.util.ArrayList;

public abstract class GameState {
  
  // Graphics
  public Spritesheet tiles = new Spritesheet("tiles.png", 32, 32);
  public Sprite castleFloor = new Sprite(0, 0, tiles);
  public Sprite water = new Sprite(1, 0, tiles);
  
  public Sprite meleeCursor = new Sprite("melee.png");
  public Sprite rangedCursor = new Sprite("ranged.png");
  
  // Lists
  protected List<Particle> particleList = new ArrayList<Particle>();
  protected List<Projectile> projectileList = new ArrayList<Projectile>();
  
  protected GameStateManager gsm;
  
  public GameState(GameStateManager gsm) {
    this.gsm = gsm;
    form = Form.DEFAULT;
    
    init();
  }
  
  public abstract void init();
  public abstract void update();
  public abstract void render();
  
  // Key Controller
  public abstract void keyPressed(String key);
  public abstract void keyReleased(String key);
  
  // Mouse Controller
  public abstract void mousePressed(String key);
  public abstract void mouseReleased(String key);
  public abstract void mouseDragged(String key);
  public abstract void mouseWheel(String key);
  
  // getters
  public GameStateManager getGSM() {
    return gsm; 
  }
  
  // setters
  public void addParticle(Particle p) {
    particleList.add(p); 
  }
  public void addProjectile(Projectile p) {
    projectileList.add(p); 
  }
  
  public void setForm() {
  // Change mouse cursor
  if(form == Form.DEFAULT)
    cursor(ARROW);
  else if(form == Form.MELEE)
    cursor(meleeCursor.getImage());
  else if(form == Form.RANGED)
    cursor(rangedCursor.getImage()); 
  }
}