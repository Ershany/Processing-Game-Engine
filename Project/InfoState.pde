public enum EnemyType {
  KRONOS, GOBLIN, SLIME, PHOENIX; 
}

public class InfoState extends GameState {
  
  private EnemyType type;
  private Sprite sprite;
  private String[] info;
  private PFont font;
  
  public InfoState(GameStateManager gsm, EnemyType type) {
    super(gsm);
    this.type = type;
    
    if(type == EnemyType.KRONOS) {
      sprite = new Sprite("Kronos_Scroll.png");
      info = new String[]{"Kronos:", "A legendary god that uses the power of", "lightning to annihilate his foes"};
    }
    else if(type == EnemyType.GOBLIN) {
      sprite = new Sprite("Goblins_Scroll.png");
      info = new String[]{"Goblins:", "Weak units that are known for their speed", "Be wary when they attack in large numbers"};
    }
    else if(type == EnemyType.SLIME) {
      sprite = new Sprite("Slimes_Scroll.png");
      info = new String[]{"Slimes:", "Stupid enemies that move very slowly", "Don't be worried about these enemies"};
    }
    else if(type == EnemyType.PHOENIX) {
      sprite = new Sprite("Phoenixes_Scroll.png");
      info = new String[]{"Phoenixes:", "A very agile enemy that can maneuver", "around easily on the battlefield"};
    }
  }
  
  public void init() {
    font = createFont("Gothic.ttf", 24, true);
  }
  
  public void update() {
    
  }
  
  public void render() {
    textFont(font);
    fill(125, 2, 88);
    image(sprite.getImage(), 0, 0);
    for(int i = 0; i < info.length; i++) {
      text(info[i], 225, 390 + (i * 30));
    }
    
    fill(255, 0, 0);
    text("Back", 350, 500);
  }
  
  public void keyPressed(String key) {
    if(key.equalsIgnoreCase("enter")) {
      gsm.getStates().pop();
    }
  }
  public void keyReleased(String key) {
    
  }
  
  public void mousePressed() {
    
  }
  public void mouseDragged() {
    
  }
  public void mouseReleased() {
    
  }
}