import java.util.ArrayList;

public class LevelOneState extends GameState {
 
 private LevelOneUI ui;
 private int wave;
  
 public LevelOneState(GameStateManager gsm) {
   super(gsm);
 }
 
 public void init() {
   map = new Tilemap("level1.png", 1024, 1024, this);
   player = new Player(1024, 1024, this);
   ui = new LevelOneUI(this);
   wave = 1;
   enemies = new ArrayList<Mob>();
   projectiles = new ArrayList<Projectile>();
   
   enemies.add(new Grunt(32 * 120, 320, map));
   enemies.add(new Grunt(32 * 122, 320, map));
   enemies.add(new Grunt(32 * 124, 320, map));
   enemies.add(new Grunt(32 * 126, 320, map));
   enemies.add(new Grunt(32 * 128, 320, map));
   enemies.add(new Grunt(32 * 130, 320, map));
   enemies.add(new Grunt(32 * 118, 320, map));
   enemies.add(new Grunt(32 * 116, 320, map));
   enemies.add(new Grunt(32 * 114, 320, map));
   enemies.add(new Grunt(32 * 112, 320, map));
   enemies.add(new Grunt(32 * 110, 320, map));
   enemies.add(new Grunt(32 * 108, 320, map));
 }
 
 public void update() {
   map.update();
   player.update();
   updateLists();
   checkRemoved();
 }
 
 public void render() {
   map.render();
   renderLists();
   player.render(map.getXOffset(), map.getYOffset());
   ui.render();
 }
 
 private void checkRemoved() {
   for(int i = 0; i < enemies.size(); i++) {
     if(enemies.get(i).getShouldRemove()) {
       enemies.remove(i);    
     }
   }
   for(int i = 0; i < projectiles.size(); i++) {
     if(projectiles.get(i).getShouldRemove()) {
       projectiles.remove(i);  
     }
   }
 }
 
 private void updateLists() {
   for(int i = 0; i < enemies.size(); i++) {
     enemies.get(i).update();  
   }
   for(int i = 0; i < projectiles.size(); i++) {
     projectiles.get(i).update();  
   }
 }
 
 private void renderLists() {
   for(int i = 0; i < enemies.size(); i++) {
     enemies.get(i).render(map.getXOffset(), map.getYOffset());
   }
   for(int i = 0; i < projectiles.size(); i++) {
     projectiles.get(i).render(map.getXOffset(), map.getYOffset());  
   }
 }
 
 // Key Controller
 public void keyPressed(String key) {
   player.keyPressed(key);
 }
 public void keyReleased(String key) {
   player.keyReleased(key);  
 }
 
 // Mouse Controller
 public void mousePressed() {
   ui.mousePressed();
   player.mousePressed();
 }
 public void mouseReleased() {
   
 }
 public void mouseDragged() {
   
 }
 
 // Getters
 public int getWave() {
   return wave;  
 }
 public Tilemap getTilemap() {
   return map;  
 }
 public Player getPlayer() {
   return player;  
 }
}