import g4p_controls.*;

boolean homeScreen = true;
boolean faqScreen = false;

PFont calistoga, abeezee;

ArrayList<symbol> ALL_SYMBOLS;
slots s;
user u;
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

  frameRate(10);
  size(1000, 700);

  createGUI();

  if (homeScreen == true) {

    ALL_SYMBOLS = new ArrayList<symbol>();

    ALL_SYMBOLS.add(new symbol("0.png", "a", 5));
    ALL_SYMBOLS.add(new symbol("1.png", "b", 2));
    ALL_SYMBOLS.add(new symbol("2.png", "c", 1.35));
    ALL_SYMBOLS.add(new symbol("3.png", "d", 1.25));
    ALL_SYMBOLS.add(new symbol("4.png", "e", 1.5));


    numImages = ALL_SYMBOLS.size();


    for (int i=0; i<numImages; i++) {
      for (int j=0; j<numImages; j++) {
        symbols[i][j] = loadImage(i+".png");
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
    u = new user("Joe", 1000);

    leverUp = loadImage("leverUp.png");
    leverUp.resize(200, 0);
    leverDown = loadImage("leverDown.png");
    leverDown.resize(200, 0);
  } else if (faqScreen == true) {
    drawFaqScreen();
  }

  ALL_SYMBOLS = new ArrayList<symbol>();

  ALL_SYMBOLS.add(new symbol("0.png", "a", 5));
  ALL_SYMBOLS.add(new symbol("1.png", "b", 2));
  ALL_SYMBOLS.add(new symbol("2.png", "c", 1.35));
  ALL_SYMBOLS.add(new symbol("3.png", "d", 1.25));
  ALL_SYMBOLS.add(new symbol("4.png", "e", 1.5));

  numImages = ALL_SYMBOLS.size();

  for (int i=0; i<numImages; i++) {
    for (int j=0; j<numImages; j++) {
      symbols[i][j] = loadImage(i+".png");
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
  u = new user("Joe", 1000);

  //lever images
  leverUp = loadImage("leverUp.jpg");
  leverUp.resize(200, 0);
  leverDown = loadImage("leverDown.jpg");
  leverDown.resize(200, 0);
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
  background(255);
  fill(0);
  circle(850, 500, 50);
  play_spin_animation();
  if (spinning == false) {
    draw_bet_info();
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
}


void play_spin_animation() {
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
    if (millis() - spin_timer >= spin_time) {
      spinning = false;
      set_slots();
    }
  }

  // Draw the images
  for (int i=0; i <3; i++) {
    for (int j=0; j<colNum; j++) {
      if (spinning) {
        image(symbols[i][(int(j + changeCol[j])) % numImages], x, y);
      } else {
        image(symbols[i][j], x, y);
      }
      x += 150;
    }
    x = 0;
    y += 150;
  }
}


void draw_bet_info() {
  fill(0, 0, 0);
  text(bet_info, 500, 500);
}

void drawFaqScreen() {
  textFont(calistoga);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("How to play:", 400, 75);

  textFont(abeezee);
  textSize(24);
  textAlign(LEFT, CENTER);
  text("It's easy to play Super Slots! Just pull the lever and watch the slots \nspin away! If you can get 3 in a row, in any direction, you win! \nEasy as that! Just make sure your balance doesn't hit zero...", 15, 200);
}
