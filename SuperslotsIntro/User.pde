class User {

  String username;
  float cash;
  
  User(String u, float c) {
    this.username = u;
    this.cash = c;
  }
  
  void saveProgress() {
    String[] stats = {this.username, str(this.cash)};
    saveStrings("progress.txt", stats);
  }
  
  void clearProgress() {
    String[] stats = {};
    saveStrings("progress.txt", stats);
  }
  
}
