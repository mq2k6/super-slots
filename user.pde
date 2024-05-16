class User {

  String username = "";
  float cash;
  int usernameLength;

  float bet;

  User(String u, float c) {
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
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }

  void spin_slots() {
    if (bet <= 0) {
      println("bet more money");
      spinning = false;
    }
    
    if (this.cash >= bet) {
      this.cash += s.spin(bet);
      spinning = true;
      this.cash -= bet;
      bet_info += "balance: " + str(this.cash) + "\n";
    }
    else {
      out_of_money = true;
      println("cash:", this.cash);
      println("bet", this.bet);
    }
  }

  void set_bet(float b) {
      this.bet = b;
  }
}
