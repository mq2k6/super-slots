class User {

  String username = "";
  float cash;
  int usernameLength;
  
  
  User(String u, float c) {
    this.username = u;
    this.cash = c;
    this.usernameLength = u.length();
  }
  
  void saveProgress() {
    String[] stats = {username, str(cash)};
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }
  
  void clearProgress() {
    String[] stats = {};
    saveStrings("progress.txt", stats);
    progress = loadStrings("progress.txt");
  }
  
}
