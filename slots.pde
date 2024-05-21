class slots {
  ArrayList<ArrayList<symbol>> machine;
  
  //arraylist for lines that denote a win
  ArrayList<line> winning_lines;
  
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
    winning_lines = new ArrayList<line>();
  }
  
  void draw_lines() {
    
    float x = (width/colNum);
    float y = 175;
    
    strokeWeight(7);
    stroke(255);
    for(int i = 0; i < winning_lines.size(); ++i) {
      PVector p1 = winning_lines.get(i).point_1;
      PVector p2 = winning_lines.get(i).point_2;
      //mustafa fix this
      line(p1.y,p1.x,p2.y ,p2.x);
    }
  }
  
  //setup 2d ArrayList
  void setup_machine() {
    machine = new ArrayList<ArrayList<symbol>>();
    for(int i = 0; i < 3; ++i) {
      ArrayList<symbol>new_row = new ArrayList<symbol>();
      //placeholder
      for(int j = 0; j < columns; ++j) {
        new_row.add(ALL_SYMBOLS.get(0));      
      }
      machine.add(new_row);
    }
  }
  
  //change number of columns
  void set_columns(int c) {
    columns = c;
    setup_machine();
  }

  
  float spin(int bet) {
    bet_info = "";
    bet_info += "bet: $" + str(bet) + "\n";
    fill_machine();
    //reset ArrayList
    winning_lines = new ArrayList<line>();
    return check_win(bet);
  }
  
  //fill machine with random symbols
  void fill_machine() {
    for(int i = 0; i < 3; ++i) {
      for(int j = 0; j < columns; ++j) {
        symbol rand_sym = ALL_SYMBOLS.get(int(random(ALL_SYMBOLS.size())));
        machine.get(i).set(j, rand_sym);
      }
    }
  }
  
  //check each cell
  float check_win(int bet) {
    int wins = 0;
    ArrayList<symbol> winners = new ArrayList<symbol>();
    for(int i = 0; i < 3; ++i) {
      for(int j = 0; j < machine.get(i).size(); ++j) {
        line new_l = new line(new PVector(i, j));
        int common_symbols = check_surround(i, j, NONE, 1, new_l);
        if(common_symbols >= 3) {
          winners.add(machine.get(i).get(j));
          wins++;
          
          winning_lines.add(new_l);
          
          //increase rewards if get more than three in a row
          if(common_symbols > 3) {
            wins = common_symbols / 3;
            wins += wins * 3;
          }
        }
      }
    }
    for(int i = 0; i < winning_lines.size(); ++i) {
    }
    //bet_info += "wins: " + str(wins) + "\n";
    int payout = calc_payout(wins, bet, winners);
    
    bet_info += "payout: " + str(payout) + "\n";
    return payout;

  }  
  
  //uses recursion to check surrounding cells for the same symbol, and detect three in a row or more
  int check_surround(int i, int j, String direction, int found, line win_line) {
    //try all "forward" directions, to prevent from counting twice
    if(direction == NONE) {
      
      //try catch for out of bounds error
      try {
        //check if east is the same
        if(machine.get(i).get(j).id == machine.get(i).get(j + 1).id) {
          win_line.set_second_point(new PVector(i, j + 1));
          //if true pass the symbols coodinates, and east as the direction
          int new_found = check_surround(i, j + 1, EAST, found + 1, win_line);
          if(new_found >= 3) {
            found += new_found;
          }
        }  
      } catch (Exception e) {
      
      }
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j + 1).id) {
          win_line.set_second_point(new PVector(i + 1, j + 1));
          int new_found = check_surround(i + 1, j + 1, SOUTH_EAST, found + 1, win_line);
          if(new_found >= 3) {
            found += new_found;
          }
        } 
      } catch (Exception e) {
      
      }
      
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j).id) {
          win_line.set_second_point(new PVector(i + 1, j));
          int new_found = check_surround(i + 1, j, SOUTH, found + 1, win_line);
          
          if(new_found >= 3) {
            found += new_found;
          }
        }  
      } catch (Exception e) {
      
      }
      
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j - 1).id) {
          win_line.set_second_point(new PVector(i + 1, j - 1));
          int new_found = check_surround(i + 1, j - 1, SOUTH_WEST, found + 1, win_line);
          if(new_found >= 3) {
            found += new_found;
          }
        }  
      } catch (Exception e) {
      
      }
    }
    
    //if passed a direction of east
    if (direction == EAST) {
      try {
        //check if east if the same
        if(machine.get(i).get(j).id == machine.get(i).get(j + 1).id) {
          win_line.set_second_point(new PVector(i, j + 1));
          //if true pass the symbols coodinates, and east as the direction
          return check_surround(i, j + 1, EAST, found + 1, win_line);
        }  
      } catch (Exception e) {
      
      }    
    } else if (direction == SOUTH_EAST) {
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j + 1).id) {
          win_line.set_second_point(new PVector(i + 1, j + 1));
          return check_surround(i + 1, j + 1, SOUTH_EAST, found + 1, win_line);
        }  
      } catch (Exception e) {
      
      }    
    } else if (direction == SOUTH) {
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j).id) {
          win_line.set_second_point(new PVector(i + 1, j));
          return check_surround(i + 1, j, SOUTH, found + 1, win_line);
        }  
      } catch (Exception e) {
      
      }
          
    } else if (direction == SOUTH_WEST) {
      try {
        if(machine.get(i).get(j).id == machine.get(i + 1).get(j - 1).id) {
          win_line.set_second_point(new PVector(i + 1, j - 1));
          
          return check_surround(i + 1, j - 1, SOUTH_WEST, found + 1, win_line);
        }  
      } catch (Exception e) {
      
      }    
    }
    
    return found;
    
  }
  
  int calc_payout(int w, int bet, ArrayList<symbol> wins) {
    int multipler = 0;
    for(int i = 0; i < wins.size(); ++i) {
      multipler += wins.get(i).value;
    }
    return w * multipler * bet;
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
