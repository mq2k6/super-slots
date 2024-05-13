import g4p_controls.*;

boolean homeScreen = true;
boolean faqScreen = false;

PFont calistoga, abeezee;

ArrayList<symbol> ALL_SYMBOLS;
slots s;
userTemp u;
String bet_info = "";
//code
int numImages = 9;

int colNum = 3;
PImage[][] symbols = new PImage[numImages][numImages]; 
PImage leverUp, leverDown;

boolean spinning = false;

float spin_timer = -1; //used to count to spin_time
float spin_time = 3000; //milliseconds

float[] changeCol = new float[numImages];
float[] columnSpeeds = new float[numImages];


void setup() {

  calistoga = createFont("Calistoga-Regular.ttf", 80);
  abeezee = createFont("ABeeZee-Regular.ttf", 24);
  size(1000, 700);
  size(1000, 700);
  esrbRating = loadImage("esrbRating.png");
  gameLogo = loadImage("gameLogo.png");
  publisherLogo = loadImage("publisherLogo.png");
  FAQbackground = loadImage("FAQbackground.png");
  engineLogo = loadImage("engineLogo.png");
  startButton = loadImage("startButton.png");
  introBackground = loadImage("introBackground.jpg");
  loginBackground = loadImage("loginBackground.jpg");
  usernameTextField = loadImage("usernameTextField.png");
  loginButton = loadImage("loginButton.png");
  FAQbanner = loadImage("FAQbanner.png");
  FAQtextField = loadImage("FAQtextField.png");
  clearProgressButton = loadImage("clearProgressButton.png");
  confirmCancelButton = loadImage("confirmCancelButton.png");
  progress = loadStrings("progress.txt");
  calistoga = createFont("Calistoga-Regular.ttf", 50);
  abeezee = createFont("ABeeZee-Regular.ttf", 24);


  gameLogo.resize(350, 280);
  startButton.resize(int(300 / 1.5), int(119 / 1.5));
  introBackground.resize(int(2490 / 2.48), int(1960 / 2.48));
  esrbRating.resize(225 / 2, 300 / 2);
  publisherLogo.resize(800 / 3, 265 / 3);
  engineLogo.resize(650 / 3, 218 / 3);
  loginBackground.resize(int(1920 / 1.8), int(1440 / 1.8));
  usernameTextField.resize(int(300 / 1.3), int(92 / 1.3));
  loginButton.resize(int(308 / 2), int(114 / 2));
  clearProgressButton.resize(int(472 / 2), int(282 / 2));
  confirmCancelButton.resize(int(458 / 3), int(208 / 3));
  FAQtextField.resize(int(689 / 1.2), int(400 / 1.2));

  if (progress.length > 0) {
    username = progress[0];
    usernameLength = username.length();
    cash = float(progress[1]);
    displayBank = displayBank.substring(0, displayBank.length() - 1);
    displayBank += nf(float(progress[1]), 0, 2);
    showClearProgress = true;
  }
  createGUI();

  if (homeScreen == true) {

    ALL_SYMBOLS = new ArrayList<symbol>();
    ALL_SYMBOLS.add(new symbol("0.jpg", "a", 5));
    ALL_SYMBOLS.add(new symbol("1.jpg", "b", 2));
    ALL_SYMBOLS.add(new symbol("2.jpg", "c", 1.35));
    ALL_SYMBOLS.add(new symbol("3.jpg", "d", 1.25));
    ALL_SYMBOLS.add(new symbol("4.jpg", "e", 1.5));
    numImages = ALL_SYMBOLS.size();


    for (int i=0; i<numImages; i++) {
      for (int j=0; j<numImages; j++) {
        symbols[i][j] = loadImage(i+".jpg"); //load symbols (in reels) images (named 0 to 8) in 2d array 
        symbols[i][j].resize(150, 150);
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
    u = new userTemp("Joe", 1000);

    leverUp = loadImage("leverUp.jpg");
    leverUp.resize(200, 0);
    leverDown = loadImage("leverDown.jpg");
    leverDown.resize(200, 0); 
  }
  
  else if (faqScreen == true) {
    drawFaqScreen();
  }
}

//set symbols to match the 2d ArrayList in slot class
void set_slots() {
  PImage[][] new_sym = s.get_2d_array();
  for (int i = 0; i < new_sym.length; ++i) {
    for (int j = 0; j < new_sym[i].length; ++j) {
      symbols[i][j] = new_sym[i][j];
      symbols[i][j].resize(150, 150);
    }
  }
}

void draw() {
  background(0);
  fill(0);
  //circle(850, 500, 50);
  if (!logoComplete) {
    introScreen();
  }
  if (logoComplete && !iconsComplete) {
    introIcons();
  }
  if (iconsComplete && !loginComplete) {
    login();
  }
   
  if (loginComplete) {   //start slots once login button is preesed
    background(255);
    play_spin_animation();
    if (spinning == false) {
      draw_bet_info();
    }
  }
}



void mouseClicked() {   //when lever clicked, spin reels
  if (mouseX < (150*colNum +180) && mouseX > 150*colNum) {   //  image width 150 x number of cols (from slider)   +   180 width (click range)   [symbol] [symbol] [symbol] [lever click range]
    if (mouseY > 100 && mouseY < 240) {    // 140 height (click range)
      if (!spinning) {
        u.spin_slots();
        spin_timer = millis();
        for (int i = 0; i < numImages; i++) {
          changeCol[i] = 0;
          columnSpeeds[i] = random(2, 10);
        }
      }
    }
  }
 

  if (mouseX < 800 && mouseX > 700) {
    if (mouseY < 100 && mouseY > 0) {
      homeScreen = false;
      faqScreen = true;
    }
  }
}


void leverImage() {
  if (spinning) 
    image(leverDown, 150*colNum, 100);
  else
    image(leverUp, 150*colNum, 100);
  strokeWeight(10);
  line(150*colNum, 0, 150*colNum, 450);
  line(0, 150*3, 150*colNum, 150*3); 
}


void play_spin_animation() {
  frameRate(10);
  float x = 0;
  float y = 0;
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
  for (int i=0; i <3; i++) {
    for (int j=0; j<colNum; j++) {
      if (spinning) 
        image(symbols[i][(int(j + changeCol[j])) % numImages], x, y);
       else 
        image(symbols[i][j], x, y); 
      x += 150;
    }
    x = 0;    //standard 2d array nested forloop
    y += 150;
  }
}


void draw_bet_info() {
  fill(0, 0, 0);
  text(bet_info, 500, 500);
}

void drawFaqScreen() {
  fill(0);
  image(FAQbackground, 0, 0);
  image(FAQbanner, width / 2 - 200, 50);
  textFont(calistoga);
  textAlign(CENTER);
  text("FAQ", width / 2, 150);
  image(FAQtextField, width / 2 - 287, 250);
  textFont(abeezee);
  //text("", ) FAQ Text
}
