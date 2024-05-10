class symbol{
  String id;
  String img_path;
  PImage img;
  symbol(String i,String p) {
    img_path = i;
    id = p;
    img = loadImage(img_path);
  }
}
