class User {

  String username = "";
  float cash;
  int usernameLength;

  float bet;

  User(String u, float c) {
    this.username = u;
    this.cash = c;
    this.usernameLength = u.length();
    this.bet = 10;
  }

  void saveProgress() {
    String[] stats = {this.username, str(this.cash)};
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }

  void clearProgress() {
    String[] stats = {};
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }

  void spin_slots() {
    this.bet = 10 * col_slider.getValueI();
    if (this.cash >= bet) {
      this.cash += s.spin(bet);
      spinning = true;
      this.cash -= bet;
      bet_info += "balance: " + str(this.cash) + "\n";
      println("balance:", this.cash);
    }
  }

  void set_bet(float b) {
    this.bet = b;
  }
}
