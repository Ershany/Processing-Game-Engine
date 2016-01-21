import java.util.Stack;

public class GameStateManager {
  
 private Stack<GameState> stack; 
  
 public GameStateManager() {
   stack = new Stack<GameState>();
 }
 
 public void init(GameState state) {
   stack.push(state);
 }
 
 public void update() {
   if(stack.size() == 0) return;
   stack.peek().update();
 }
 
 public void render() {
   if(stack.size() == 0) return;
   stack.peek().render();
 }
 
 // Key Controller
 public void keyPressed(String key) {
   if(stack.size() == 0) return;
   stack.peek().keyPressed(key); 
 }
 public void keyReleased(String key) {
   if(stack.size() == 0) return;
   stack.peek().keyReleased(key);
 }
 
 // Mouse Controller
 public void mousePressed(String key) {
   if(stack.size() == 0) return;
   stack.peek().mousePressed(key);
 }
 public void mouseReleased(String key) {
   if(stack.size() == 0) return;
   stack.peek().mouseReleased(key);
 }
 public void mouseDragged(String key) {
   if(stack.size() == 0) return;
   stack.peek().mouseDragged(key);
 }
 public void mouseWheel(String key) {
   if(stack.size() == 0) return;
   stack.peek().mouseWheel(key);
 }
 
 // Getters
 public Stack<GameState> getStates() {
   return stack; 
 }
 
}