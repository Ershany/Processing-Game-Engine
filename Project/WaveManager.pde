public class WaveManager {
  
  private PFont font;
  private LevelOneState state;
  private int xSpawn, ySpawn;
  public boolean inProgress;
  public int currentWave = 0;
  public int cycle = 0;
  
  // Adjustable stats
  private final int betweenWaveTimer = 2400;
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
        state.calculateAIPath(74, 17);
        roundEnding = false;
      }
    }
    else {
      ticksIntoWave++;
      // Else the game is in progress
      if(ticksIntoWave % frequency == 0 && !roundEnding) {
        // Set waves spawns
        if(currentWave == 1) {
          if(ticksIntoWave == frequency) {
            if(cycle == 0)
              state.getGSM().getStates().push(new InfoState(state.getGSM(), EnemyType.SLIME));
          }
          state.enemies.add(new Grunt(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));
        }
        else if(currentWave == 2) {
          if(ticksIntoWave == frequency) {
            if(cycle == 0)
              state.getGSM().getStates().push(new InfoState(state.getGSM(), EnemyType.GOBLIN));
          }
          state.enemies.add(new Speeder(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));
        }
        else if(currentWave == 3) {
          if(ticksIntoWave == frequency) {
            if(cycle == 0)
              state.getGSM().getStates().push(new InfoState(state.getGSM(), EnemyType.PHOENIX));
          }
          state.enemies.add(new Flyer(32 * 95, 32 * 17, state.getTilemap(), cycle)); 
        }
        else if(currentWave == 4) {
          if(ticksIntoWave == frequency) {
            if(cycle == 0)
              state.getGSM().getStates().push(new InfoState(state.getGSM(), EnemyType.WITCH));
          }
          state.enemies.add(new Witch(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));
        }
        else if(currentWave == 5) {
          if(Math.random() * 3 <= 1) {
            state.enemies.add(new Speeder(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));
          }
          if(Math.random() * 4 <= 1) {
            state.enemies.add(new Flyer(32 * 95, 32 * 17, state.getTilemap(), cycle)); 
          }
          if(Math.random() * 3 <= 1) {
            state.enemies.add(new Grunt(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));
          }
          if(Math.random() * 4 <= 1) {
            state.enemies.add(new Witch(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));  
          }
        }
        else if(currentWave == 6) { // Kronos Wave
          if(ticksIntoWave == frequency) {
            if(cycle == 0)
              state.getGSM().getStates().push(new InfoState(state.getGSM(), EnemyType.KRONOS));
            frequency = 1;
            state.enemies.add(new Kronos(32 * 74, 32 * 17, state.getTilemap(), (Stack<Node>)state.pathing.clone(), cycle));
          }
          // Check to see if Kronos casted flash
          for(int i = 0; i < state.enemies.size(); i++) {
            if(state.enemies.get(i) instanceof Kronos) {
              Kronos boss = (Kronos)state.enemies.get(i);
              if(boss.flash) {
                state.flash = true;
                boss.flash = false;
              }
            }
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
          frequency = 90 - (cycle * 10);
          if(frequency < 20) 
            frequency = 20;
            
          waveReward = 200;
          waveLength = 1800;  
        }
        else if(currentWave == 2) { //round 3
          frequency = 100 - (cycle * 10);
          if(frequency < 20) 
            frequency = 20;
            
          waveReward = 200;
          waveLength = 1005; 
          state.isChanging = false;
          state.isNight = false;
          state.isChanging = true;
        }
        else if(currentWave == 3) { // round 4
          frequency = 100 - (cycle * 10);
          if(frequency < 20)
            frequency = 20;
            
          waveReward = 200;
          waveLength = 1005;
        }
        else if(currentWave == 4) { //round 5
          frequency = 70 - (cycle * 10);
          if(frequency < 20)
            frequency = 20;
          waveReward = 200;
          waveLength = 1800;
        }
        else if(currentWave == 5) { //round 6
          frequency = 100;
            
          waveReward = 500;
          waveLength = 400;
          state.isChanging = false;
          state.isNight = true;
          state.isChanging = true;
        }
        else if(currentWave == 6) { //round 7
          cycle++;
          currentWave = 0;
          frequency = 90 - (cycle * 10);
          if(frequency < 20) 
            frequency = 20;
            
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
  
  public void keyPressed(String k) {
    if(k.equalsIgnoreCase("begin")) {
      if(!inProgress) {
        currentWaveTimer = 1;
      }
    }
  }
  
}