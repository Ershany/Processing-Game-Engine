public class WaveManager {
 
  private PFont font;
  private LevelOneState state;
  private int xSpawn, ySpawn;
  public boolean inProgress;
  public int currentWave = 0;
  
  // Adjustable stats
  private final int betweenWaveTimer = 1800;
  private int currentWaveTimer = betweenWaveTimer;
  
  private int ticksIntoWave = 0;
  
  private int frequency = 120;
  
  private int waveLength = 1800;
  
  private int waveReward = 100;
  
  public WaveManager(int x, int y, LevelOneState state) {
    this.state = state;
    this.xSpawn = x;
    this.ySpawn = y;
    
    font = createFont("Gothic.ttf", 24, true);  
  }
  
  public void update() {
    // If the wave is not in progress, then keep the timer going
    if(!inProgress) {
      currentWaveTimer--;
      if(currentWaveTimer <= 0) {
        inProgress = true;
        currentWaveTimer = betweenWaveTimer;
        currentWave++;
        state.calculateAIPath();
      }
    }
    else {
      ticksIntoWave++;
      // Else the game is in progress
      if(ticksIntoWave % frequency == 0)
        state.enemies.add(new Grunt(32 * 75, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone()));
        
      if(ticksIntoWave >= waveLength) {
        ticksIntoWave = 0;
        inProgress = false;
        state.getPlayer().addGold(waveReward);
      }
    }
  }
  
  public void render() {
    // If the wave is not in progress, keep the user up to date when it will start
    if(!inProgress) {
      fill(125, 2, 88);
      textFont(font);
      
      text((currentWaveTimer/60 + 1) + " seconds until next wave", 275, 150);
    }
  }
  
}