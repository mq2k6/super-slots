class User {

  String username;
  int cash;
  int usernameLength;
  int bet;

  User(String u, int c) {
    this.username = u;
    this.cash = c;
    this.usernameLength = u.length();
    this.bet = 10;  //minimum & initial bet
    
  }

  void saveProgress() { // this methods is to save progress, the username and cash are saved to a list which is then added to the progress text file, replacing whatever is in it
    String[] stats = {this.username, str(this.cash)};
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }

  void clearProgress() { // this method does the opposite of the previous one, it clears the display username and feeds the progress text file an empty list so that the next time the program is run, it is like the first time
    this.username = "";
    String[] stats = {};
    this.cash = 1000;
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
    this.usernameLength = 0;
    showWelcomeMessage = false;
  }

  void spin_slots() { // this method is responsisble for the user clicking the lever an initiating the spinning animation

    if (bet <= 0) { //makes sure the bet is larger than zero to continue first
      spinning = false;
    }
    
    if (this.cash >= bet) {  // make sure we have enough cash for the bet
      this.cash += s.spin(bet);
      spinning = true;
      this.cash -= bet;
      displayBank = displayBank.substring(0, 10);
      displayBank += account.cash;
    }
    else {
      out_of_money = true;
    }
  }

  
}
