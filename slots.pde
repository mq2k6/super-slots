class slots {
  ArrayList<ArrayList<symbol>> machine;
  
  int columns;
  
  //constant variables for logic in check_surround()
  final String NONE = "n";
  final String EAST = "e";
  final String SOUTH_EAST = "se";
  final String SOUTH = "s";
  final String SOUTH_WEST = "w";
  
  slots(int c) {
    columns = c;
    setup_machine();
  }
  
  //setup 2d ArrayList
  void setup_machine() {
    machine = new ArrayList<ArrayList<symbol>>();
    for(int i = 0; i < 3; ++i) {
      ArrayList<symbol>new_row = new ArrayList<symbol>();
      //placeholders
      for(int j = 0; j < columns; ++j) {
        new_row.add(new symbol("0.jpg", "z"));      
      }
      machine.add(new_row);
    }
  }
  
  //change number of columns
  void set_columns(int c) {
    columns = c;
    setup_machine();
  }

  
  void spin(float bet) {
    println("bet:", bet);
    fill_machine();
    check_win(bet);
  }
  
  //fill machine with random symbols
  void fill_machine() {
    for(int i = 0; i < 3; ++i) {
      for(int j = 0; j < columns; ++j) {
        symbol rand_sym = ALL_SYMBOLS.get(int(random(ALL_SYMBOLS.size())));
        machine.get(i).set(j, rand_sym);
        print(rand_sym.id + " ");
      }
      println();
    }
    println();
  }
  
  //check each cell
  void check_win(float bet) {
    int wins = 0;
    for(int i = 0; i < 3; ++i) {
      for(int j = 0; j < machine.get(i).size(); ++j) {
        if(check_surround(i, j, NONE, 1)) {
          wins++;
        }
      }
    }
    println("wins:", wins);
    println("payout", calc_payout(wins, bet));
    println();
  }  
  
  //uses recursion to check surrounding cells for the same symbol, and detect three in a row or more
  boolean check_surround(int i, int j, String direction, int found) {
    
    //try all "forward" directions, to prevent from counting twice
    if(direction == NONE) {
      
      //try catch for out of bounds error
      try {
        if(machine.get(i).get(j).id == machine.get(i).get(j + 1).id) {
          return check_surround(i, j + 1, EAST, found + 1);
        }  
      } catch (Exception e) {
      
      }

      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j + 1).id) {
          return check_surround(i + 1, j + 1, SOUTH_EAST, found + 1);
        }  
      } catch (Exception e) {
      
      }
      
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j).id) {
          return check_surround(i + 1, j, SOUTH, found + 1);
        }  
      } catch (Exception e) {
      
      }
      
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j - 1).id) {
          return check_surround(i + 1, j - 1, SOUTH_WEST, found + 1);
        }  
      } catch (Exception e) {
      
      }
    }
    
    if(direction == EAST) {
      try {
        if(machine.get(i).get(j).id == machine.get(i).get(j + 1).id) {
          return check_surround(i, j + 1, EAST, found + 1);
        }  
      } catch (Exception e) {
      
      }    
    } else if (direction == SOUTH_EAST) {
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j + 1).id) {
          return check_surround(i + 1, j + 1, SOUTH_EAST, found + 1);
        }  
      } catch (Exception e) {
      
      }    
    } else if (direction == SOUTH) {
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j).id) {
          return check_surround(i + 1, j, SOUTH, found + 1);
        }  
      } catch (Exception e) {
      
      }
          
    } else if (direction == SOUTH_WEST) {
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j - 1).id) {
          return check_surround(i + 1, j - 1, SOUTH_WEST, found + 1);
        }  
      } catch (Exception e) {
      
      }    
    }
    
    if(found >= 3) {
      return true;
    } else {
      return false;
    }
    
  }
  
  float calc_payout(int w, float bet) {
    return w * 1.35 * bet;
  }
  
  PImage[][] get_2d_array() {
    PImage[][] new_sym = new PImage[3][columns];
    for(int i = 0; i < 3; ++i) {
      for(int j = 0; j < columns; ++j) {
        new_sym[i][j] = machine.get(i).get(j).img;
      }
    }
    return new_sym;
  }
}
