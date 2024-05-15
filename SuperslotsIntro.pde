PImage esrbRating, gameLogo, publisherLogo, engineLogo, introBackground, startButton, loginBackground, usernameTextField, loginButton, clearProgressButton, confirmCancelButton, FAQbackground, FAQbanner, FAQtextField;
boolean logoComplete, iconsComplete, loginComplete, showConfirmCancel, showClearProgress, FAQcomplete;
int exposure = 50;
String[] progress;
String displayBank = "Cash: $0";
String username = "";
float cash;
int usernameLength = 0;
User account;

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
  text("Super Slots® involves chance. We advise players to play responsibly within their means.", 300, 610);
  if (exposure >= 0.005) {
    exposure -= 0.0025;
  } else {
    background(0);
    exposure =  255;
    iconsComplete = true;
  }
}

void login() {

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

  if ((keyPressed && key == ENTER && account.usernameLength > 0) || (mousePressed && mouseX > width / 2 - 77 && mouseX < width / 2 - 77 + loginButton.width && mouseY > height / 2 - 50 && mouseY < height / 2 - 50 + loginButton.height && account.usernameLength > 0)) {
    background(0);
    loginComplete = true;
    account.saveProgress();
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
