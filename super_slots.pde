import g4p_controls.*;


boolean homeScreen = true;
boolean out_of_money = false;
boolean bet_more = false;
boolean showFAQ;

PFont calistoga, abeezee;

ArrayList<symbol> ALL_SYMBOLS;

slots s;
User account;

String bet_info = "";
//code
int numImages = 9;

int colNum = 3;
//int betSlide = 10;  //for bet slider

PImage[][] symbols = new PImage[numImages][numImages];
PImage leverUp, leverDown, faqButton, faqBackButton;

boolean spinning = false;


float spin_timer = -1; //used to count to spin_time
float spin_time = 3000; //milliseconds

float[] changeCol = new float[numImages];
float[] columnSpeeds = new float[numImages];


void setup() {
  account = new User("", 1000);

  calistoga = createFont("Calistoga-Regular.ttf", 50);
  abeezee = createFont("ABeeZee-Regular.ttf", 24);
  size(1200, 700);
  esrbRating = loadImage("esrbRating.png");
  gameLogo = loadImage("gameLogo.png");
  publisherLogo = loadImage("publisherLogo.png");
  homeScreenBackground = loadImage("homeScreenBackground.png");
  engineLogo = loadImage("engineLogo.png");
  startButton = loadImage("startButton.png");
  introBackground = loadImage("introBackground.jpg");
  loginBackground = loadImage("loginBackground.jpg");
  usernameTextField = loadImage("usernameTextField.png");
  loginButton = loadImage("loginButton.png");
  FAQbanner = loadImage("FAQbanner.png");
  FAQtextField = loadImage("FAQtextField.png");
  FAQbutton = loadImage("faqButton.png");
  clearProgressButton = loadImage("clearProgressButton.png");
  faqButton = loadImage("faqButton.png");
  confirmCancelButton = loadImage("confirmCancelButton.png");
  faqBackButton = loadImage("FAQbackButton.png");
  progress = loadStrings("progress.txt");

  FAQbutton.resize(411 / 4, 456 / 4);
  gameLogo.resize(350, 280);
  startButton.resize(int(300 / 1.5), int(119 / 1.5));
  introBackground.resize(int(2490 / 2), int(1960 / 2));
  esrbRating.resize(225 / 2, 300 / 2);
  publisherLogo.resize(800 / 3, 265 / 3);
  engineLogo.resize(650 / 3, 218 / 3);
  loginBackground.resize(1600, 1200);
  usernameTextField.resize(int(300 / 1.3), int(92 / 1.3));
  loginButton.resize(int(308 / 2), int(114 / 2));
  clearProgressButton.resize(int(472 / 2), int(282 / 2));
  confirmCancelButton.resize(int(458 / 3), int(208 / 3));
  FAQtextField.resize(800, 464);

  if (progress.length > 0) {
    account.username = progress[0];
    account.cash = int(progress[1]);
    displayBank = displayBank.substring(0, displayBank.length() - 7);
    displayBank += nf(float(progress[1]), 0, 2);
    showClearProgress = true;
  }


  if (homeScreen == true) {
    createGUI();
    col_slider.setVisible(false);
    //change_bet.setVisible(false);
    Change_BetLabel.setVisible(false);
    Change_Col.setVisible(false);
    increaseBet.setVisible(false);
    decreaseBet.setVisible(false);
    ALL_SYMBOLS = new ArrayList<symbol>();
    ALL_SYMBOLS.add(new symbol("0.png", "a", 5));
    ALL_SYMBOLS.add(new symbol("1.png", "b", 2));
    ALL_SYMBOLS.add(new symbol("2.png", "c", 1.35));
    ALL_SYMBOLS.add(new symbol("3.png", "d", 1.25));
    ALL_SYMBOLS.add(new symbol("4.png", "e", 1.25));
    ALL_SYMBOLS.add(new symbol("5.png", "f", 1.25));

    
    
    numImages = ALL_SYMBOLS.size();


    for (int i=0; i<numImages; i++) {
      for (int j=0; j<numImages; j++) {
        symbols[i][j] = loadImage(i+".png"); //load symbols (in reels) images (named 0 to 8) in 2d array
        symbols[i][j].resize(125, 125);
      }
    }

    // Shuffle the images
    for (int i = 0; i < numImages; i++) {
      for (int j = 0; j < numImages; j++) {
        int randomI = int(random(numImages));
        int randomJ = int(random(numImages));
        PImage temp = symbols[i][j];
        symbols[i][j] = symbols[randomI][randomJ];
        symbols[randomI][randomJ] = temp;
      }
    }
    s = new slots(colNum);

    leverUp = loadImage("leverUp.png");
    leverUp.resize(175, 0);
    leverDown = loadImage("leverDown.png");
    leverDown.resize(175, 0);
    
  }
}

//set symbols to match the 2d ArrayList in slot class
void set_slots() {
  PImage[][] new_sym = s.get_2d_array();
  for (int i = 0; i < new_sym.length; ++i) {
    for (int j = 0; j < new_sym[i].length; ++j) {
      symbols[i][j] = new_sym[i][j];
      symbols[i][j].resize(125, 125);
    }
  }
}

void draw() {
  background(0);
  fill(0);
  if (!logoComplete) {
    introScreen();
  }
  if (logoComplete && !iconsComplete) {
    introIcons();
  }
  if (iconsComplete && !loginComplete) {
    login();
  }

  if (loginComplete && !showFAQ) {   //start slots once login button is preesed
    col_slider.isVisible();
    Change_BetLabel.isVisible();
    Change_Col.isVisible();
    increaseBet.isVisible();
    decreaseBet.isVisible();
    image(homeScreenBackground, 0, 0);
    play_spin_animation();
     
    

    if (spinning == false) {
      draw_bet_info();
      fill(255);
      text(round(account.bet), 1150, 275);
      textSize(14);
      fill(255,255,0);
      text("Balance", 1130, 410);  //keep at this height for need more money & bet more text 
      text(nf(account.cash,0,2), 1130, 430);      
      account.saveProgress();
    }
  }
  
  if(showFAQ) {
    FAQ();
  }
  
  // special cases for betting & cash
  if (out_of_money) {
    fill(255);
    textSize(14);
    text("need more money", 1060, 392);
  }
  else
    out_of_money = false;
    
  if (bet_more) {
    fill(255);
    textSize(14);
    text("bet more", 1120, 392);
  }
  else
    bet_more = false;
  
  if(!spinning) {
    s.draw_lines();  
  }
}



void mouseClicked() {   //when lever clicked, spin reels
  if (mouseX < ((width/colNum) + 125*colNum +180) && mouseX > (width/colNum) + 125*colNum) {   //  image width 150 x number of cols (from slider)   +   180 width (click range)   [symbol] [symbol] [symbol] [lever click range]
    if (mouseY > 250 && mouseY < 375) {    // 140 height (click range)
      if (!spinning) {
        if (account.cash > 0) {
          out_of_money = false;
          if (account.bet > 0) {
            bet_more = false;
            account.spin_slots();
            spin_timer = millis();
            for (int i = 0; i < numImages; i++) {
              changeCol[i] = 0;
              columnSpeeds[i] = random(2, 10);
            }
          }
          else {
            spinning = false;
            bet_more = true;
          }
        }
        else {
            spinning = false;
            out_of_money = true;
        }
      }
    }
  }


}


void leverImage() {
  if (spinning) {
    image(leverDown, (width/colNum) + 125*colNum - 8, (height/3)-115+150);
    col_slider.setVisible(false);
    Change_BetLabel.setVisible(false);
    Change_Col.setVisible(false);
    increaseBet.setVisible(false);
    decreaseBet.setVisible(false);

  } else {
    image(leverUp, (width/colNum) + 125*colNum - 8, (height/3)-115+150);
    col_slider.setVisible(true);
    Change_BetLabel.setVisible(true);
    Change_Col.setVisible(true);
    increaseBet.setVisible(true);
    decreaseBet.setVisible(true);

  }
 
  noStroke();
  fill(0, 100);
  rect((width/colNum) - 50, (height/3)-115, 125*colNum+50, 425, 25, 25, 25, 25);
}


void play_spin_animation() {
  if(!spinning) {
  image(faqButton, 25, 15);
    if(mouseX >= 25 && mouseX <= 25 + 80 && mouseY >= 15 && mouseY <= 15 + 79 && mousePressed) {
      showFAQ = true;
    }
  }
  frameRate(30);
  float x = (width/colNum)-25;
  float y = (height/3) - 90;    
  
  leverImage(); //lever animation

  // Update column offsets and speeds
  if (spinning) {
    for (int i = 0; i < numImages; i++) {
      changeCol[i] += columnSpeeds[i];
      columnSpeeds[i] += 0.1; // Increase speed over time
      if (changeCol[i] >= 150) {
        changeCol[i] -= 150; // Reset to the top of the column
        columnSpeeds[i] = random(2, 10); // Set a new random speed
      }
    }
    if (millis() - spin_timer >= spin_time) {   //auto stop reels
      spinning = false;
      set_slots();
    }
  }

  // Draw the images
  int delayMS = 5;
  for (int i=0; i <3; i++) {
    for (int j=0; j<colNum; j++) {
      if (spinning) {
        image(symbols[i][(int(j + changeCol[j%5])) % numImages], x, y);
        delay(delayMS);
      } else {
        image(symbols[i][j%5], x, y);
      }
      x += 125;
    }
    x = (width/colNum)-25;    //standard 2d array nested forloop
    y += 125;
  }
}


void draw_bet_info() {
  fill(255);
  text(bet_info, 500, 500);
}

void FAQ() {
  col_slider.setVisible(false);
  Change_Col.setVisible(false);
  increaseBet.setVisible(false);
  decreaseBet.setVisible(false);
  Change_BetLabel.setVisible(false);
  fill(0);
  image(homeScreenBackground, 0, 0);
  image(faqBackButton, 20, 640);
  image(FAQbanner, width / 2 - 200, 50);
  textFont(calistoga);
  textAlign(CENTER);
  text("FAQ", width / 2, 150);
  textSize(24);
  image(FAQtextField, width / 2 - 400, 225);
  textAlign(LEFT);
  float startX = width / 2 - 360;
  float startY = 285;
  float secondQAStartY = startY + 170;
  float thirdQAStartY = secondQAStartY + 115;

  text("Q: How can I control the slot machine?", startX, startY);
  text("Q: Does this game save my progress?", startX, secondQAStartY);
  text("Q: How much is each slot symbol worth?", startX, thirdQAStartY);

  textFont(abeezee);

  text("A: Simply choose the size of your bet using the buttons on the ", startX, startY + 30);
  text("right hand side, then click the lever to spin the reels! You may", startX, startY + 60);
  text("choose the difficulty of the game using the columns slider in", startX, startY + 90);
  text("the top right hand corner.", startX, startY + 120);

  text("A: Absolutely. All users should be comfortable knowing that ", startX, secondQAStartY + 30);
  text("their progress is continuously being saved into the game files.", startX, secondQAStartY + 60);

  text("A: Each symbol multiplies your bet by a certain factor ranging ", startX, thirdQAStartY + 30);
  text("from 1.25x and up to 5x. Refer to the user manual for details.", startX, thirdQAStartY + 60);

  if (mousePressed && mouseX >= 20 && mouseX <= 110 && mouseY >= 640 && mouseY <= 685) {
    showFAQ = false;
  }
}
