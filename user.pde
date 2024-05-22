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

  void saveProgress() {
    String[] stats = {this.username, str(this.cash)};
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }

  void clearProgress() {
    this.username = "";
    String[] stats = {};
    this.cash = 1000;
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
    this.usernameLength = 0;
    showWelcomeMessage = false;
  }

  void spin_slots() {

    if (bet <= 0) {
      spinning = false;
    }
    
    if (this.cash >= bet) { 
      this.cash += s.spin(bet);
      spinning = true;
      this.cash -= bet;
      displayBank = displayBank.substring(0, displayBank.length() - 4);
      displayBank += account.cash;
    }
    else {
      out_of_money = true;
    }
  }

  
}
