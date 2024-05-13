PImage esrbRating, gameLogo, publisherLogo, engineLogo, introBackground, startButton, loginBackground, usernameTextField, loginButton, clearProgressButton, confirmCancelButton;
boolean logoComplete, iconsComplete, loginComplete, showConfirmCancel, showClearProgress;
int exposure = 50;
String[] progress;
String displayBank = "Cash: $0";
String username = ""; 
float cash; 
int usernameLength = 0;

void setup() {
  size(1000, 700);
  esrbRating = loadImage("esrbRating.png");
  gameLogo = loadImage("gameLogo.png");
  publisherLogo = loadImage("publisherLogo.png");
  engineLogo = loadImage("engineLogo.png");
  startButton = loadImage("startButton.png");
  introBackground = loadImage("introBackground.jpg");
  loginBackground = loadImage("loginBackground.jpg");
  usernameTextField = loadImage("usernameTextField.png");
  loginButton = loadImage("loginButton.png");
  clearProgressButton = loadImage("clearProgressButton.png");
  confirmCancelButton = loadImage("confirmCancelButton.png");
  progress = loadStrings("progress.txt");

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

  if (progress.length > 0) {
    username = progress[0];
    usernameLength = username.length();
    cash = float(progress[1]);
    displayBank = displayBank.substring(0, displayBank.length() - 1);
    displayBank += nf(float(progress[1]), 0, 2);
    showClearProgress = true;
  }
}

void draw() {
  background(0);
  if (!logoComplete) {
    introScreen();
  }
  if (logoComplete && !iconsComplete) {
    introIcons();
  }
  if (iconsComplete && !loginComplete) {
    login();
  }
}

void introScreen() {
  tint(exposure);
  image(introBackground, 0, 0);
  image(gameLogo, width / 2 - 175, height / 2 - 300);
  image(startButton, width / 2 - 100, height / 2 + 50);
  if (exposure <= 252) {
    exposure += 3;
  } else {
    if ((mousePressed && mouseX > width / 2 - 100 && mouseX < width / 2 - 100 + startButton.width && mouseY > height / 2 + 50 && mouseY < height / 2 + 50 + startButton.height) || (keyPressed && key == ENTER)) {
      background(0);
      logoComplete = true;
    }
  }
}

void introIcons() {
  fill(exposure);
  tint(exposure);
  image(introBackground, 0, 0);
  image(esrbRating, width / 2 + 100, height / 2 - 25);
  image(publisherLogo, width / 2 - 225, height / 2);
  image(engineLogo, 15, height - 70);
  textSize(15);
  text("Super Slots® involves chance. We advise players to play responsibly within their means.", 200, 610);
  if (exposure >= 0.005) {
    exposure -= 0.0025;
  } else {
    background(0);
    exposure =  255;
    iconsComplete = true;
  }
}

void login() {
  User account = new User(username, cash);
  tint(exposure);
  image(loginBackground, 0, 0);
  if (showClearProgress) {
    image(clearProgressButton, width / 2 - 118, height / 2 + 50);
  }
  if (showConfirmCancel && showClearProgress) {
    image(confirmCancelButton, width / 2 - 76, height / 2 + 225);
  }
  image(loginButton, width / 2 - 77, height / 2 - 50);
  image(usernameTextField, width / 2 - 115, height / 2 - 120);
  fill(255);
  text(displayBank, 15, 35);
  if (progress.length > 0) {
    text("Welcome Back!", width / 2 - 95, height / 2 - 115);
  } else {
    text("Enter Username", width / 2 - 95, height / 2 - 115);
  }
  fill(0);

  if (account.usernameLength == 0) {
    text("|", width / 2 - 95, height / 2 - 80);
  } else {
    text(account.username, width / 2 - 95, height / 2 - 78);
  }
  if ((keyPressed && key == ENTER && account.usernameLength > 0) || (mousePressed && mouseX > width / 2 - 77 && mouseX < width / 2 - 77 + loginButton.width && mouseY > height / 2 - 50 && mouseY < height / 2 - 50 + loginButton.height && account.usernameLength > 0)) {
    background(0);
    loginComplete = true;
    account.saveProgress();
  }

  if (mousePressed && mouseX > width / 2 - 118 && mouseX < width / 2 - 118 + clearProgressButton.width && mouseY > height / 2 + 50 && mouseY < height / 2 + 50 + clearProgressButton.height && showClearProgress) {
    showConfirmCancel = true;
  }

  if (mousePressed && mouseX > width / 2 - 76 && mouseX < width / 2 - 10 && mouseY > height / 2 + 225 && mouseY < height / 2 + 225 + confirmCancelButton.height && mouseX < width / 2 - 20 + confirmCancelButton.width / 2 && showConfirmCancel) {
    account.clearProgress();
    usernameLength = 0;
    username = "";
    displayBank = "Cash: $0";
    showConfirmCancel = false;
    showClearProgress = false;
  }
  if (mousePressed && mouseX > width / 2 - 70 + confirmCancelButton.width / 2 && mouseX < width / 2 - 75 + confirmCancelButton.width && mouseY > height / 2 + 225 && mouseY < height / 2 + 225 + confirmCancelButton.height && showConfirmCancel) {
    showConfirmCancel = false;
  }
}

void keyPressed() {
  if (iconsComplete && !loginComplete) {
    if (keyCode == BACKSPACE && usernameLength > 0) {
      username = username.substring(0, username.length() - 1);
      usernameLength--; 
    } else if (usernameLength < 9 && keyCode != BACKSPACE && keyCode != ENTER && keyCode != SHIFT) {
      if (key != CODED) { 
        username += key;
        usernameLength++;
      }
    }
  }
}
