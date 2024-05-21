PImage esrbRating, gameLogo, publisherLogo, engineLogo, introBackground, startButton, loginBackground, usernameTextField, loginButton, clearProgressButton, confirmCancelButton, homeScreenBackground, FAQbanner, FAQtextField, FAQbutton;
boolean logoComplete, iconsComplete, loginComplete, showConfirmCancel, showClearProgress;
int exposure = 50;
String[] progress;
String displayBank = "Cash: $1000.00";

void introScreen() {
  tint(exposure);
  image(introBackground, 0, 0);
  image(gameLogo, width / 2 - 175, height / 2 - 300); 
  image(startButton, width / 2 - 100, height / 2 + 50);    //Initializing images
  if (exposure <= 252) {
    exposure += 3;    //Changes darkness of the intro screen, create fade effect
  } else {
    if ((mousePressed && mouseX > width / 2 - 100 && mouseX < width / 2 - 100 + startButton.width && mouseY > height / 2 + 50 && mouseY < height / 2 + 50 + startButton.height) || (keyPressed && key == ENTER)) {
      background(0); // Checking if user presses start button
      account.usernameLength = account.username.length();
      logoComplete = true;
    } 
  }
}

void introIcons() {    //Creates game info screen, right before login
  fill(exposure);
  tint(exposure);
  image(introBackground, 0, 0);
  image(esrbRating, width / 2 + 100, height / 2 - 25);
  image(publisherLogo, width / 2 - 225, height / 2);
  image(engineLogo, 15, height - 70);
  textSize(15);
  text("Super Slots® involves chance. We advise players to play responsibly within their means.", 300, 600);
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
  if(showWelcomeMessage) {
    text("Welcome Back!", width / 2 - 95, height / 2 - 115);
  } else {
    text("Enter Username", width / 2 - 95, height / 2 - 115);
  }
  fill(0);
  if (account.usernameLength == 0) {
    text("|", width / 2 - 95, height / 2 - 80);    //If the username text box is empty, emulate cursor display
  } else {
    text(account.username, width / 2 - 95, height / 2 - 78);
  }

  if (mousePressed && mouseX > width / 2 - 118 && mouseX < width / 2 - 118 + clearProgressButton.width && mouseY > height / 2 + 50 && mouseY < height / 2 + 50 + clearProgressButton.height && showClearProgress) {
    showConfirmCancel = true;    // If the user presses the Clear Progress button
  }

  if (mousePressed && mouseX > width / 2 - 76 && mouseX < width / 2 - 10 && mouseY > height / 2 + 225 && mouseY < height / 2 + 225 + confirmCancelButton.height && mouseX < width / 2 - 20 + confirmCancelButton.width / 2 && showConfirmCancel) {
    account.clearProgress();
    displayBank = "Cash: $1000.00";
    showConfirmCancel = false;
    showClearProgress = false;    //When the user clears their progress, bank resets to $1000, and the user is returned to main login
  }
  if (mousePressed && mouseX > width / 2 - 70 + confirmCancelButton.width / 2 && mouseX < width / 2 - 75 + confirmCancelButton.width && mouseY > height / 2 + 225 && mouseY < height / 2 + 225 + confirmCancelButton.height && showConfirmCancel) {
    showConfirmCancel = false;    //If user presses cancel, hide the confirm/cancel button
  }

  if ((keyPressed && key == ENTER && account.usernameLength > 0) || (mousePressed && mouseX > width / 2 - 77 && mouseX < width / 2 - 77 + loginButton.width && mouseY > height / 2 - 50 && mouseY < height / 2 - 50 + loginButton.height && account.usernameLength > 0)) {
    loginComplete = true;
    account.saveProgress();    //Saves user id for next login
  }
}

void keyPressed() {      //Username entry handling
  if (iconsComplete && !loginComplete) {
    account.usernameLength = account.username.length();
    if (keyCode == BACKSPACE && account.usernameLength > 0) {
      account.username = account.username.substring(0, account.username.length() - 1);
      account.usernameLength--;
    } else if (account.usernameLength < 9 && keyCode != BACKSPACE && keyCode != ENTER && keyCode != SHIFT) {
      if (key != CODED) {
        account.username += key;
        account.usernameLength++;
      }
    }
  }
}
