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
   protected int hotkey; // Used as a shortcut instead of clicking the tower (ie. hitting '3' instead of clicking the button)
    
  
   // When and if we have sprites
   public UIButton(float x, float y, PImage image, int hotkey) {
       super(x, y);
       this.image = image;
       this.hotkey = hotkey;
   }
   
   public UIButton(float x, float y, int[] rgb, int hotkey) {
       super(x, y);
       this.rgb = rgb;
       this.hotkey = hotkey;
   }
   
   public boolean isMouseInside() {
      if (x < mouseX && mouseX < x + radius && y < mouseY && mouseY < y + radius) {
         return true; 
      }
      return false;
   }
  
   public abstract void click();
   
   // Setters
   public void setHotkey(int num) {
     hotkey = num;
   }
}

public class TowerPurchaseButton extends UIButton {
 
    // Hotkey display font
    PFont font = createFont("Arial", 20, true);
  
    public TowerPurchaseButton(float x, float y, int[] rgb, int hotkey) {
        super(x, y, rgb, hotkey);
    }
    public TowerPurchaseButton(float x, float y, PImage image, int hotkey) {
      super(x, y, image, hotkey);  
    }
    
    public void render() {
      if(image == null) {
        fill(rgb[0], rgb[1], rgb[2]);  
        ellipse(x, y, radius, radius);
      }
      else {
        image(image, x, y);    
        fill(255, 0, 0);
        textFont(font);
        text(hotkey, x + radius / 2 - 7, y + 53);
      }
    }
    
    public void click() {
        println("Tower1PurchaseButton clicked");
    }
}
/* --------------End Buttons----------------- */