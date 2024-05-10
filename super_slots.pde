import g4p_controls.*;

ArrayList<symbol> ALL_SYMBOLS;
slots s;

//inaccurate
int numImages = 9;
//lol

int colNum = 3;
PImage[][] symbols = new PImage[numImages][numImages];

boolean spinning = false;

float spin_timer = -1; //used to count to spin_time
float spin_time = 3000; //milliseconds

float[] changeCol = new float[numImages];
float[] columnSpeeds = new float[numImages];


void setup() {
  
  
  frameRate(10);
  size(1000, 700);
  
  createGUI();
  
  background(255);
  


  ALL_SYMBOLS = new ArrayList<symbol>();
  
  ALL_SYMBOLS.add(new symbol("0.jpg","a"));
  ALL_SYMBOLS.add(new symbol("1.jpg","b"));
  ALL_SYMBOLS.add(new symbol("2.jpg","c"));
  ALL_SYMBOLS.add(new symbol("3.jpg","d"));
  ALL_SYMBOLS.add(new symbol("4.jpg","e"));
  
  numImages = ALL_SYMBOLS.size();
  
  for (int i=0; i<numImages; i++) {
    for (int j=0; j<numImages; j++) {
      symbols[i][j] = loadImage(i+".jpg");
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
  
}

//set symbols to match the 2d ArrayList in slot class
void set_slots() {
  PImage[][] new_sym = s.get_2d_array();
  for(int i = 0; i < new_sym.length; ++i) {
    for(int j = 0; j < new_sym[i].length; ++j) {
      symbols[i][j] = new_sym[i][j];
      symbols[i][j].resize(150, 150);
    }
  }
}

void draw() {
  background(255);
  float x = 0;
  float y = 0;

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
    if(millis() - spin_timer >= spin_time) {
      spinning = false;
      set_slots();
    }
  }

  // Draw the images
  for (int i=0; i <3; i++) {
    for (int j=0; j<colNum; j++) {
      if(spinning) {
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

void mousePressed() {
  spinning = true;
  spin_timer = millis();
  s.spin(10);
  for (int i = 0; i < numImages; i++) {
    changeCol[i] = 0;
    columnSpeeds[i] = random(2, 10);
  }
}
