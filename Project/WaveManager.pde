public class WaveManager {
 
  private PFont font;
  private LevelOneState state;
  private int xSpawn, ySpawn;
  public boolean inProgress;
  public int currentWave = 0;
  
  // Adjustable stats
  private final int betweenWaveTimer = 1800;
  private int currentWaveTimer = betweenWaveTimer;
  private boolean roundEnding;
  
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
        roundEnding = false;
      }
    }
    else {
      ticksIntoWave++;
      // Else the game is in progress
      if(ticksIntoWave % frequency == 0 && !roundEnding) {
        // Set waves spawns
        if(currentWave == 1) {
          state.enemies.add(new Grunt(32 * 75, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone()));
        }
        else if(currentWave == 2) {
          state.enemies.add(new Speeder(32 * 75, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone()));
        }
        else if(currentWave == 3) {
          state.enemies.add(new Flyer(32 * 75, 32 * 17, state.getTilemap())); 
        }
        else if(currentWave == 4) {
          if(Math.random() * 3 <= 1) {
            state.enemies.add(new Speeder(32 * 75, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone()));
          }
          if(Math.random() * 3 <= 1) {
            state.enemies.add(new Flyer(32 * 75, 32 * 17, state.getTilemap())); 
          }
          if(Math.random()* 3 <= 1) {
            state.enemies.add(new Grunt(32 * 75, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone()));
          }
        }
        
      }
      
      if(ticksIntoWave >= waveLength) roundEnding = true;
      if(ticksIntoWave >= waveLength && state.enemies.size() == 0) {
        ticksIntoWave = 0;
        inProgress = false;
        state.getPlayer().addGold(waveReward);
        
        // Set next waves variables
        if(currentWave == 1) { // round 2
          frequency = 90;  
          waveReward = 150;
          waveLength = 1800; 
        }
        else if(currentWave == 2) { //round 3
          frequency = 100;
          waveReward = 200;
          waveLength = 1005; 
        }
        else if(currentWave == 3) { //round 4 
          frequency = 70;
          waveReward = 200;
          waveLength = 1800; 
        }
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