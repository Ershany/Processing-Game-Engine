public class LevelOneState extends GameState {
 
 private Player player;
 private Tilemap map;
  
 public LevelOneState(GameStateManager gsm) {
   super(gsm);
 }
 
 public void init() {
   map = new Tilemap("level1.png", 1024, 1024, this);
   player = new Player(1024, 1024, map);
 }
 
 public void update() {
   map.update();
   player.update();
   updateLists();
   checkRemoved();
   player.update();
 }
 
 public void render() {
   map.render();
   player.render(map.getXOffset(), map.getYOffset());
   renderLists();
 }
 
 private void checkRemoved() {
   
 }
 
 private void updateLists() {
   
 }
 
 private void renderLists() {
   
 }
 
 // Key Controller
 public void keyPressed(String key) {
   player.keyPressed(key);
 }
 public void keyReleased(String key) {
   player.keyReleased(key);  
 }
}