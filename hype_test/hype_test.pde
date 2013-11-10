HColorPool colors;
HDrawablePool pool;

void setup() {
  size(300, 300);
  H.init(this).background(#202020);
  smooth();
  colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600).fillOnly();
  
  pool = new HDrawablePool(121);
  pool. 

