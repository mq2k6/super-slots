class userTemp {
  String name;
  float balance;
  
  float bet = 10 * colNum;
  
  userTemp(String n, float b) {
    name = n;
    balance = b;
  }
  
  void spin_slots() {
    if(balance >= bet) {
      balance += s.spin(bet);
      spinning = true;
      balance -= bet;
      bet_info += "balance: " + str(balance) + "\n";
      println("balance:", balance);
    }
  }
  
  void set_bet(float b) {
    bet = b;
  }
  
  void save_game() {
  
  }
}
