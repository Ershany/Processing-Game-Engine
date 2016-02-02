public abstract class UIElement {
      
     protected float x;
     protected float y;
    

     // When and if we have sprites
     public UIElement(float x, float y) {
         this.x = x;
         this.y = y;
     }
     
     public abstract void render();
}

/* --------------Buttons----------------- */
public abstract class UIButton extends UIElement {
  
   protected float radius = 35.0f;
   protected PImage image;
   protected int[] rgb;
    
  
   // When and if we have sprites
   public UIButton(float x, float y, PImage image) {
       super(x, y);
       this.image = image;
   }
   
   public UIButton(float x, float y, int[] rgb) {
       super(x, y);
       this.rgb = rgb;
   }
   
   public boolean isPressed() {
      if (x < mouseX && mouseX < x + radius && y < mouseY && mouseY < y + radius) {
         return true; 
      }
      return false;
   }
  
   public abstract void click();
}

public class Tower1PurchaseButton extends UIButton {
 
    public Tower1PurchaseButton(float x, float y, int[] rgb) {
        super(x, y, rgb);
    }
    
    public void render() {
      fill(rgb[0], rgb[1], rgb[2]);  
      ellipse(x, y, radius, radius);
    }
    
    public void click() {
        println("Tower1PurchaseButton clicked");
    }
}
/* --------------End Buttons----------------- */