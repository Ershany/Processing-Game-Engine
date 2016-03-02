public class LevelOneUI {
 
  protected LevelOneState state;
  private UIButton[] buttons;
  
  public LevelOneUI(LevelOneState state) {
    this.state = state;  
    setup();
  }
  
  public void setup() {
    buttons = new UIButton[] {
      new TowerPurchaseButton(50, height - 75, new Sprite("ProjectileTowerUI.bmp").getImage(), 1, new String("Basic Tower that fires projectiles at enemies\nDamage: 5\nAttackSpeed: 50\nRange: 150\nCost: 100")),
      new TowerPurchaseButton(100, height - 75, new Sprite("SlowTowerUI.bmp").getImage(), 2, new String("Slowing Tower that slows enemy units movement\nDamage: 10\nAttackSpeed: 140\nRange: 100\nCost: 200")),
      new TowerPurchaseButton(150, height - 75, new Sprite("PoisonTowerUI.bmp").getImage(), 3, new String("Poison Tower that poisons enemy units (stackable)\nDamage: 5\nAttackSpeed: 60\nRange: 175\nCost: 250"))
    };
  }
   
  
  public void render() {
      for (UIButton button: buttons) {
         button.render(); 
      }
      for (UIButton button: buttons) {
         if (button.isMouseInside()) {
           button.inside();
         }
      }
  }
  
  public void mousePressed() {
    /*for (UIButton button: buttons) {
         if (button.isMouseInside()) {
           button.click();
         }
    }*/
  }
  
}