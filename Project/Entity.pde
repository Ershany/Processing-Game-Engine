public class Entity {
  
   protected float x, y;
   public boolean shouldRemove;
   
   public Entity(float x, float y) {
     this.x = x;
     this.y = y;
   }
   
   // getters
   public float getX() {
     return x; 
   }
   public float getY() {
    return y; 
   }
}