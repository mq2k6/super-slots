class line {    //Shortcuts to quickly calculate win lines
  PVector point_1;
  PVector point_2;
  line(PVector p1) {
    point_1 = p1;
  }
  
  void set_second_point(PVector p2) {
    point_2 = p2;
  }
}
