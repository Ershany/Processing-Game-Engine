import java.util.ArrayList;
import java.util.List;

public class MenuState extends GameState {
 
 private Tilemap map;
 
 private String[] choices = { "Play", "Info", "Quit" };
 private PFont font;
 private int currentChoice = 0;
  
 public MenuState(GameStateManager gsm) {
   super(gsm);
 }
 
 public void init() {
   map = new Tilemap("menu.png", 64, 64, this);
   font = createFont("Arial", 64, true);
   textFont(font);
 }
 
 public void update() {
   map.update();
   moveMap();
   spawnParticles();
   updateLists();
   checkRemoved();
 }
 
 public void render() {
   map.render();
   renderLists();
   
   // Draw choices
   for(int i = 0; i < choices.length; i++) {
     if(currentChoice == i) {
       fill(255, 0, 0);  
     }
     else {
       fill(255);
     }
     text(choices[i], 350, 100 + 125 * i);
   }
 }
 
 private void checkRemoved() {
   for(int i = 0; i < particleList.size(); i++) {
     if(particleList.get(i).shouldRemove) {
       particleList.remove(i);
     }
   }
 }
 
 private void moveMap() {
   map.addOffset(0, 2); 
 }
 
 private void updateLists() {
   for(int i = 0; i < particleList.size(); i++) {
     particleList.get(i).update();
   }
 }
 
 private void renderLists() {
   for(int i = 0; i < particleList.size(); i++) {
     particleList.get(i).render(map.getXOffset(), map.getYOffset());
   }
 }
 
 private void spawnParticles() {
   int changeY = (int)(Math.random() * 50 - 25);
   int startY = 0;
   
   switch(currentChoice) {
     case 0:
       startY = 75;
       break;
     case 1:
       startY = 200;
       break;
     case 2:
       startY = 325;
       break;
   }
   
   //info on orig and spray
   //75 200 325   spray 25
   
   new Spawner(Type.PARTICLE, -30, startY + changeY, 13.2f, 0f, new RGB(255, 0, 0), 80, 30, 2, 1, RenderType.STATIC, this);
 }

  
  // Key Controller
 public void keyPressed(String key) {
   // Check if the player hit enter
   if(key.equalsIgnoreCase("enter")) {
     if(currentChoice == 0) {
        gsm.getStates().pop();
        gsm.getStates().push(new LevelOneState(gsm));
     }
     else if(currentChoice == 1) {
       
     }
     else {
       System.exit(0);
     }
   }
   
   // If the player changes options, clear the particles
   if(key.equalsIgnoreCase("up")) {
     currentChoice--; 
     particleList.clear();
   }
   else if(key.equalsIgnoreCase("down")) {
     currentChoice++;
     particleList.clear();
   }
   
   // Ensure currentChoice does not go out of bounds
   if(currentChoice <= -1) {
     currentChoice = choices.length - 1;
   }
   else if(currentChoice >= choices.length) {
     currentChoice = 0;
   }
 }
 public void keyReleased(String key) {
   
 }
 
 // Mouse Controller
 public void mousePressed(String key) {
   
 }
 public void mouseReleased(String key) {
   
 }
 public void mouseDragged(String key) {
   
 }
 public void mouseWheel(String key) {
   
 }
}