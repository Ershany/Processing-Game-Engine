public class Player extends Mob {
 
 // Camera controls
 private float panSpeed = 4.1f;
 private int panArea = 10;
 private boolean moveUp, moveDown, moveRight, moveLeft; 
  
 public Player(float x, float y, Tilemap map) {
   super(x, y, map);
   
   init();
 }
 
 // Test
 public void init() {
   xSpeed = panSpeed;
   ySpeed = xSpeed / 4 * 3;
   /*health = 100;
   width = 32;
   height = 32;
   hitbox = new Rectangle((int)x, (int)y, width, height);*/
 }
 
 public void update() {
   checkPan();
   checkMovement();
   checkOffset();
 }
 
 public void render(int xOffset, int yOffset) {
   //ellipse(x - xOffset, y - yOffset, 20, 20);
 }
 
 private void checkPan() {
   if(mouseX >= Project.WIDTH - panArea) 
     moveRight = true;
   else 
     moveRight = false;
   if(mouseX <= panArea)
     moveLeft = true;
   else
     moveLeft = false;
   if(mouseY >= Project.HEIGHT - panArea)
     moveDown = true;
   else 
     moveDown = false;
   if(mouseY <= panArea)
     moveUp = true;
   else 
     moveUp = false;
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
   // Change player position
   x += xChange;
   
   // Make sure the offset does not go off of the map
   if(x < 512) 
     x = 512;
   else if(x > (map.getWidth() << 5) - 512)
     x = (map.getWidth() << 5) - 512;
   if(y < 412)
     y = 412;
   if(y > (map.getHeight() << 5) - 412)
     y = (map.getHeight() << 5) - 412;
 }
 private void moveY(float yChange) {  
   // Change player position
   y += yChange;
   
   // Make sure the offset does not go off of the map
   //if(y < 312)
 }
 
 // Key Controller
 public void keyPressed(String key) {
   /*if(key.equalsIgnoreCase("up")) {
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
   }*/
 }
 public void keyReleased(String key) {
   /*if(key.equalsIgnoreCase("up")) {
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
   }*/
 }
 
}