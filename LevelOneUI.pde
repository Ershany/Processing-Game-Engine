public class LevelOneUI {
 
  protected GameState state;
  private UIButton[] buttons;
  
  public LevelOneUI(GameState state) {
    this.state = state;  
    setup();
  }
  
  public void setup() {
    buttons = new UIButton[] {
      new Tower1PurchaseButton(width - 50, height - 50, new int[] {0, 255, 0})
    };
  }
  
   
  
  public void render() {
      for (UIButton button: buttons) {
         button.render(); 
      }
  }
  
  public void mousePressed() {
    for (UIButton button: buttons) {
         if (button.isMouseInside()) {
           button.click(); 
         }
    }
  }
  
}