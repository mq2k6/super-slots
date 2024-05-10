class symbol{
  String id;
  String img_path;
  PImage img;
  
  float value;
  
  symbol(String i,String p, float v) {
    img_path = i;
    id = p;
    img = loadImage(img_path);
    
    value = v;
  }
}
