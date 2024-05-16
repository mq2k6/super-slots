/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void custom_slider1_change1(GCustomSlider source, GEvent event) { //_CODE_:col_slider:546561:
  colNum = col_slider.getValueI();
  s.set_columns(colNum);
} //_CODE_:col_slider:546561:

public void bet_slider(GCustomSlider source, GEvent event) { //_CODE_:change_bet:596327:
  betSlide = change_bet.getValueF();
  account.set_bet(betSlide);
  println("change_bet - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:change_bet:596327:

// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  col_slider = new GCustomSlider(this, 1056, 0, 144, 48, "grey_blue");
  col_slider.setShowValue(true);
  col_slider.setLimits(3.0, 3.0, 5.0);
  col_slider.setNbrTicks(3);
  col_slider.setStickToTicks(true);
  col_slider.setShowTicks(true);
  col_slider.setNumberFormat(G4P.DECIMAL, 1);
  col_slider.setOpaque(false);
  col_slider.addEventHandler(this, "custom_slider1_change1");
  
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  change_bet = new GCustomSlider(this, 1225, 200, 300, 75, "grey_blue");
  change_bet.setLimits(1.0, 10.0, 500.0);
  change_bet.setNumberFormat(G4P.DECIMAL, 2);
  change_bet.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  change_bet.setShowLimits(true);
  change_bet.setOpaque(false);
  change_bet.setNbrTicks(11);
  change_bet.setShowTicks(true);
  change_bet.setEasing(6.0);
  change_bet.setNumberFormat(G4P.INTEGER, 0);  
  change_bet.setRotation(PI/2);
  change_bet.addEventHandler(this, "bet_slider");
  Change_BetLabel = new GLabel(this, 1115, 180, 80, 20);
  Change_BetLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Change_BetLabel.setText("Change Bet");
  Change_BetLabel.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  Change_BetLabel.setOpaque(true);
}

// Variable declarations 
// autogenerated do not edit
GCustomSlider col_slider; 
GCustomSlider change_bet; 
GLabel Change_BetLabel; 
