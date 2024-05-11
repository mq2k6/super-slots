class user {
  String name;
  float balance;
  
  float bet = 10;
  
  user(String n, float b) {
    name = n;
    balance = b;
  }
  
  void spin_slots() {
    if(balance >= bet) {
      balance += s.spin(bet);
      spinning = true;
      balance -= bet;
      println("balance:", balance);
    }
  }
  
  void set_bet(float b) {
    bet = b;
  }
  
  void save_game() {
  
  }
}
