import java.util.ArrayList;
import java.util.*;

public class LevelOneState extends GameState {
 
 private LevelOneUI ui;
 public WaveManager waveManager;
 
 private int xDest, yDest;
 private Stack<Node> pathing;
 
 public int castleHealth = 20;
 private PFont font;
 
 public LevelOneState(GameStateManager gsm) {
   super(gsm);
 }
 
 public void init() {
   waveManager = new WaveManager(74, 17, this);
   map = new Tilemap("level1.png", 1024, 1024, this);
   player = new Player(1024, 1024, this);
   ui = new LevelOneUI(this);
   enemies = new ArrayList<Mob>();
   projectiles = new ArrayList<Projectile>();
   font = createFont("Gothic.ttf", 24, true);
   
   xDest = 17;
   yDest = 17;
   pathing = findPath(74, 17, xDest, yDest);
 }
 
 public void update() {
   map.update();
   player.update();
   updateLists();
   checkRemoved();
   waveManager.update();
   checkPathing();
 }
 
 int protoEnd = 0;
 public void render() {
   map.render();
   renderCastle();
   renderLists();
   player.render(map.getXOffset(), map.getYOffset());
   ui.render();
   renderCastleLife();
   checkCastleLife();
   waveManager.render();
   
   // PROTOTYPE TEMP ENDING
   if(waveManager.currentWave == 4) {
     protoEnd++;
     if(protoEnd > 2000)
       text("You have completed the prototype!", 250, 200);
     if(protoEnd > 2800) {
       gsm.getStates().pop();  
       gsm.getStates().push(new MenuState(gsm));
     }
   }
   // END PROTOTYPE TEMP ENDING
 }
 
 private void renderCastle() {
   if(player.x < 1150) {
     image(castle.getImage(), (9 * 32) - map.getXOffset(), (10 * 32) - map.getYOffset());  
   }
 }
 
 private void renderCastleLife() {
   fill(125, 2, 88);
   textFont(font);
   text("Castle Health Remaining: " + castleHealth, 520, 25);  
 }
 
 private void checkRemoved() {
   for(int i = 0; i < enemies.size(); i++) {
     if(enemies.get(i).getShouldRemove()) {
       if(((int)enemies.get(i).x >> 5) < 19)
         castleHealth--;
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
 
 int counter = 0;
 private void checkCastleLife() {
   if(castleHealth <= 0) {
     castleHealth = 0;
     fill(125, 2, 88);
     textFont(font);
     text("Your Kingdom Has Been Destroyed!", 225, 275);
     counter++;
     if(counter > 360) {
       gsm.getStates().pop();  
       gsm.getStates().push(new MenuState(gsm));
     }
   }
 }
 
 // Method that ensures that pathing is available, and if it is not. Then destroy towers until a path can be made
 private void checkPathing() {
   if(pathing == null) {
     while(pathing == null) {
       map.destroyRandomTower();
       pathing = findPath(74, 17, xDest, yDest);
     }
   }
 }
 
 // A* Pathfinding
 public Stack<Node> findPath(int xStart, int yStart, int xDest, int yDest) {
   List<Node> openList = new ArrayList<Node>();
   List<Node> closedList = new ArrayList<Node>();
   Node current = new Node(xStart, yStart, null, 0, getDistance(xStart, yStart, xDest, yDest));
   openList.add(current);
   // Keep going until everything is searched
   while(openList.size() > 0) {
     // Move the nodes with the lowest costs to the front
     Collections.sort(openList);
     current = openList.get(0);
     // If path is find return our path
     if(current.x == xDest && current.y == yDest) {
       Stack<Node> stack = new Stack<Node>();
       while(current.parent != null) {
         stack.push(current);
         current = current.parent;
       }
       openList.clear();
       closedList.clear();
       return stack;
     }
     openList.remove(current);
     closedList.add(current);
     // Loop through adjacent tiles (not diagonal)
     for(int i = 0; i < 4; i++) {
       int x = current.x;
       int y = current.y;
       int xi = 0;
       int yi = 0;
       if(i == 0) {
         xi = -1;
       }
       else if(i == 1) {
         yi = -1;
       }
       else if(i == 2) {
         yi = 1;
       }
       else if(i == 3) {
         xi = 1;
       }
       Tile at = map.getTile((x + xi) << 5, (y + yi) << 5);
       if(at == null) continue;
       if(at.getWalkSolid()) continue;
       int newX = x + xi;
       int newY = y + yi;
       double gCost = current.gCost + getDistance(x, y, newX, newY);
       double hCost = getDistance(x, y, xDest, yDest);
       Node node = new Node(newX, newY, current, gCost, hCost);
       if(coordInList(closedList, newX, newY) && gCost >= node.gCost) continue;
       if(!coordInList(openList, newX, newY) || gCost < node.gCost) openList.add(node);
     }
   }
   closedList.clear();
   return null;
 }
 
 private boolean coordInList(List<Node> list, int x, int y) {
   for(Node n: list) {
     if(n.x == x && n.y == y) {
       return true;
     }
   }
   return false;
 }
 
 // Heuristic Calc
 private double getDistance(int xStart, int yStart, int xDest, int yDest) {
   double dx = xStart - xDest;
   double dy = yStart - yDest;
   return Math.sqrt(dx * dx + dy * dy);
   //return ((Math.abs((xStart >> 5) - (xDest >> 5))) + (Math.abs((yStart >> 5) - (yDest >> 5))));
 }
 
 private void calculateAIPath() {
   pathing = findPath(74, 17, xDest, yDest);  
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
 public Tilemap getTilemap() {
   return map;  
 }
 public Player getPlayer() {
   return player;  
 }
}