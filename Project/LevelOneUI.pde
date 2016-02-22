public class LevelOneUI {
 
  protected LevelOneState state;
  private UIButton[] buttons;
  
  public LevelOneUI(LevelOneState state) {
    this.state = state;  
    setup();
  }
  
  public void setup() {
    buttons = new UIButton[] {
      new TowerPurchaseButton(50, height - 75, new Sprite("ProjectileTowerUI.bmp").getImage(), 1)
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