PImage esrbRating, gameLogo, publisherLogo, engineLogo, introBackground, startButton, loginBackground, usernameTextField, loginButton, clearProgressButton, confirmCancelButton;
boolean logoComplete, iconsComplete, loginComplete, showConfirmCancel;
int exposure = 50;
String[] progress;
String username = ""; 
int usernameLength; 
float cash = 0;
String bankBalance = "Cash: $0";

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
    username += progress[0];
    usernameLength += progress[0].length();
    cash = float(progress[1]);
    bankBalance = bankBalance.substring(0, bankBalance.length() - 1);
    bankBalance += nf(float(progress[1]), 0, 2);
  }
}

void draw() {
  background(0);
  if (logoComplete == false) {
    introScreen();
  }
  if (logoComplete == true && iconsComplete == false) {
    introIcons();
  }
  if (iconsComplete == true && loginComplete == false) {
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
    if (mousePressed && mouseX > width / 2 - 100 && mouseX < width / 2 - 100 + startButton.width && mouseY > height / 2 + 50 && mouseY < height / 2 + 50 + startButton.height) {
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
  image(clearProgressButton, width / 2 - 118, height / 2 + 50);
  image(loginButton, width / 2 - 77, height / 2 - 50);
  image(usernameTextField, width / 2 - 115, height / 2 - 120);
  fill(255);
  text(bankBalance, 15, 35);
  if (progress.length > 0) {
    text("Welcome Back!", width / 2 - 95, height / 2 - 120);
  } else {
    text("Enter Username", width / 2 - 95, height / 2 - 115);
  }
  fill(0);
  if (usernameLength == 0) {
    text("|", width / 2 - 95, height / 2 - 80);
  } else {
    text(username, width / 2 - 95, height / 2 - 78);
  }
  if (keyPressed && key == ENTER || (mousePressed && mouseX > width / 2 - 77 && mouseX < width / 2 - 77 + loginButton.width && mouseY > height / 2 - 50 && mouseY < height / 2 - 50 + loginButton.height && usernameLength > 0)) {
    background(0);
    loginComplete = true;
    account.saveProgress();
  }

  if (mousePressed && mouseX > width / 2 - 118 && mouseX < width / 2 - 118 + clearProgressButton.width && mouseY > height / 2 + 50 && mouseY < height / 2 + 50 + clearProgressButton.height) {
    showConfirmCancel = true;
  }
  fill(255);
  if (mousePressed && mouseX > width / 2 - 76 && mouseX < width / 2 - 10 && mouseY > height / 2 + 225 && mouseY < height / 2 + 225 + confirmCancelButton.height && mouseX < width / 2 - 20 + confirmCancelButton.width / 2 && showConfirmCancel == true) {
    account.clearProgress();
    text("Progress cleared successfully.", width / 2 - 90, height / 2 + 250);
    username = "";
    usernameLength = 0;
    cash = 0;
    bankBalance = "Cash: $0";
    showConfirmCancel = false;
  }
  if (mousePressed && mouseX > width / 2 - 70 + confirmCancelButton.width / 2 && mouseX < width / 2 - 75 + confirmCancelButton.width && mouseY > height / 2 + 225 && mouseY < height / 2 + 225 + confirmCancelButton.height && showConfirmCancel == true) {
    text("Progress not cleared.", width / 2 - 80, height / 2 + 250);
    showConfirmCancel = false;
  }

  if (showConfirmCancel == true) {
    image(confirmCancelButton, width / 2 - 76, height / 2 + 225);
  }
}

void keyPressed() {
  if (iconsComplete == true && loginComplete == false) {
    if (usernameLength < 9 && key != BACKSPACE && keyCode != 32 && key != ENTER && keyCode == 0) {
      username += str(key);
      usernameLength++;
    }
    if (key == BACKSPACE && usernameLength > 0) {
      username = username.substring(0, usernameLength - 1);
      usernameLength--;
    }
  }
}
