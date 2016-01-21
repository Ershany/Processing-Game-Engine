private Game game;

public static final int WIDTH = 800;
public static final int HEIGHT = 600;
public static Form form = Form.DEFAULT;

void setup() {
  size(800, 600);
  game = new Game();
}

void draw() {
  game.update();
  game.render();
}

// Key Controller
void keyPressed() {
   if(key == 'w' || keyCode == UP)
     game.keyPressed("up");
   else if(key == 's' || keyCode == DOWN)
     game.keyPressed("down");
   else if(key == 'a' || keyCode == LEFT) 
     game.keyPressed("left");
   else if(key == 'd' || keyCode == RIGHT)
     game.keyPressed("right");
   else if(keyCode == ENTER) //escape key
     game.keyPressed("enter");
}
void keyReleased() {
   if(key == 'w' || keyCode == UP)
     game.keyReleased("up");
   else if(key == 's' || keyCode == DOWN)
     game.keyReleased("down");
   else if(key == 'a' || keyCode == LEFT) 
     game.keyReleased("left");
   else if(key == 'd' || keyCode == RIGHT)
     game.keyReleased("right");
}

// Mouse Controller
void mousePressed() {
  String name = "";
  if(mouseButton == LEFT) 
    name = "left";
  else if(mouseButton == RIGHT)
    name = "right";
  game.mousePressed(name);
}
void mouseDragged() {
  game.mouseDragged("");
}
void mouseReleased() {
  String name = "";
  if(mouseButton == LEFT)
    name = "left";
  else if(mouseButton == RIGHT)
    name = "right";
  game.mouseReleased(name);
}
void mouseWheel(MouseEvent e) {
  game.mouseWheel("");
}

class Game {
  
 private GameStateManager gsm;
  
 // Initialize instances of objects
 public Game() {
   //start the gsm and give it the state
   gsm = new GameStateManager();
   MenuState state = new MenuState(gsm);
   gsm.init(state);
 }
 
 public void update() {
   gsm.update();
 }
 
 public void render() {
   gsm.render();
 }
 
 // Key Controller
 public void keyPressed(String key) {
   gsm.keyPressed(key);
 }
 public void keyReleased(String key) {
   gsm.keyReleased(key); 
 }
 
 // Mouse Controller
 public void mousePressed(String key) {
   gsm.mousePressed(key);
 }
 public void mouseReleased(String key) {
   gsm.mouseReleased(key);
 }
 public void mouseDragged(String key) {
   gsm.mouseDragged(key);
 }
 public void mouseWheel(String key) {
   gsm.mouseWheel(key);
 }
}