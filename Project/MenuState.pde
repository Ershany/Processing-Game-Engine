import java.util.ArrayList;
import java.util.List;

public class MenuState extends GameState {
 
 //Logo 
 private Sprite logo;
  
 private Tilemap map;
 
 private String[] choices1 = { "Play", "Credits", "Quit" };
 private String[] choices2 = { "Easy", "Normal", "Hard" };
 private int currentSet = 0;
 
 private PFont font;
 private int currentChoice = 0;
  
 public MenuState(GameStateManager gsm) {
   super(gsm);
 }
 
 public void init() {
   cursor(cursorImage.getImage(), 0, 0);
   map = new Tilemap("menu.png", 64, 64, this);
   font = createFont("Gothic.ttf", 64, true);
   logo = new Sprite("Logo.png");
   textFont(font);
 }
 
 public void update() {
   map.update();
   moveMap();
   spawnParticles();
   updateLists();
   checkRemoved();
   
   // Smooth map loop
   if(map.getYOffset() >= 3600) {
     map.setOffset(64, 64 + (map.getYOffset() % 3600)); 
   }
 }
 
 public void render() {
   map.render();
   renderLists();
   
   // Draw logo
   image(logo.getImage(), 247, 10);
   
   textFont(font);
   // Draw choices
   for(int i = 0; i < choices1.length; i++) {
     if(currentChoice == i) {
       fill(255, 0, 0);  
     }
     else {
       fill(255);
     }
     if(currentSet == 0) {
       text(choices1[i], 387 - (choices1[i].length() * 10), 300 + 125 * i);
     }
     else {
       text(choices2[i], 387 - (choices1[i].length() * 10), 300 + 125 * i);  
     }
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
       startY = 275;
       break;
     case 1:
       startY = 400;
       break;
     case 2:
       startY = 525;
       break;
   }
   
   // Spawn particles
   new Spawner(Type.PARTICLE, -30, startY + changeY, 13.2f, 0f, new RGB(255, 0, 0), 80, 30, 2, 1, RenderType.STATIC, this);
 }

  
  // Key Controller
 public void keyPressed(String key) {
   // Check if the player hit enter
   if(key.equalsIgnoreCase("enter")) {
     if(currentChoice == 0 && currentSet == 0) {
        currentSet = 1;
     }
     else if(currentChoice == 1 && currentSet == 0) {
        gsm.getStates().push(new CreditsState(gsm));
     }
     else if(currentChoice == 2 && currentSet == 0) {
       System.exit(0);
     }
     
     else if((currentChoice == 0 || currentChoice == 1 || currentChoice == 2) && currentSet == 1) {
        if(currentChoice == 0) 
          difficulty = GameDifficulty.EASY;
        else if(currentChoice == 1) 
          difficulty = GameDifficulty.NORMAL;
        else 
          difficulty = GameDifficulty.HARD;
        
        gsm.getStates().pop();
        gsm.getStates().push(new LevelOneState(gsm));
        gsm.getStates().push(new InfoState(gsm, EnemyType.INTRO2));
        gsm.getStates().push(new InfoState(gsm, EnemyType.INTRO1));
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
     currentChoice = choices1.length - 1;
   }
   else if(currentChoice >= choices1.length) {
     currentChoice = 0;
   }
 }
 public void keyReleased(String key) {
   
 }
 
 // Mouse Controller
 public void mousePressed() {
   
 }
 public void mouseReleased() {
   
 }
 public void mouseDragged() {
   
 }
}