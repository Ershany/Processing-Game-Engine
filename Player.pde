public enum Form {
  MELEE, RANGED, DEFAULT
}

public class Player extends Mob {
  
 private boolean moveUp, moveDown, moveRight, moveLeft; 
 private GameState state;
  
 public Player(float x, float y, Tilemap map, GameState state) {
   super(x, y, map);
   this.state = state;
   
   init();
 }
 
 public void init() {
   health = 100;
   xSpeed = 2.2f;
   ySpeed = xSpeed / 4 * 3;
   width = 32;
   height = 32;
   hitbox = new Rectangle((int)x, (int)y, width, height);
   
   // Set new cursor
   form = Form.MELEE;
   state.setForm();
 }
 
 public void update() {
   cooldownManager.update();
   checkMovement();
   checkOffset();
 }
 
 public void render(int xOffset, int yOffset) {
   ellipse(x - xOffset, y - yOffset, 20, 20);
 }
 
 float xChange, yChange;
 private void checkMovement() {
   xChange = 0; yChange = 0;
   if(moveUp)
     yChange -= ySpeed;
   if(moveDown)
     yChange += ySpeed;
   if(moveRight)
     xChange += xSpeed;
   if(moveLeft)
     xChange -= xSpeed;
   
   moveX(xChange);
   moveY(yChange);
 }
 
 private void checkOffset() {
   map.setOffset((int)x - 400, (int)y - 300); 
 }
 
 private void moveX(float xChange) {  
   if(map.getTile((int)(x + xChange), (int)y).getWalkSolid()) {
     return;  
   }
   
   // Change player position
   x += xChange;
   hitbox.x = (int)x;
 }
 private void moveY(float yChange) {  
   if(map.getTile((int)x, (int)(y + yChange)).getWalkSolid()) {
     return;  
   }
   
   // Change player position
   y += yChange;
   hitbox.y = (int)y;
 }
 
 private void checkAttack(String key) {
   if(key.equalsIgnoreCase("left")) {
     
   }
 }
 
 // Cooldown Manager
 public void cooldownEvent(String cooldown) {
   
 }
 
 // Key Controller
 public void keyPressed(String key) {
   if(key.equalsIgnoreCase("up")) {
     moveUp = true;
   }
   if(key.equalsIgnoreCase("down")) {
     moveDown = true; 
   }
   if(key.equalsIgnoreCase("right")) {
     moveRight = true;
   }
   if(key.equalsIgnoreCase("left")) {
     moveLeft = true;
   }
 }
 public void keyReleased(String key) {
   if(key.equalsIgnoreCase("up")) {
     moveUp = !moveUp;
   }
   if(key.equalsIgnoreCase("down")) {
     moveDown = !moveDown; 
   }
   if(key.equalsIgnoreCase("right")) {
     moveRight = !moveRight;
   }
   if(key.equalsIgnoreCase("left")) {
     moveLeft = !moveLeft;
   }
 }
 
 // Mouse Controller
 public void mouseWheel(String key) {
   if(form == Form.MELEE) 
     form = Form.RANGED;
   else if(form == Form.RANGED)
     form = Form.MELEE;
   
   state.setForm();
 }
 public void mousePressed(String key) {
   checkAttack(key);
 }
 
}