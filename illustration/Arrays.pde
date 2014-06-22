class ColorShapeArrays {
  ArrayList<PShape> shapes; 
  int[] colors;

  ColorShapeArrays(ArrayList _shapes, int[] _colors) {
    shapes = _shapes;                                                                                
    colors = _colors;
  }
  
  
  PShape getRandomShape() {
    int r = (int)random(0, shapes.size());
    return shapes.get(r);
  }

  color getRandomColor() {
    int c = (int)random(0, colors.length);
    return colors[c];
  }
}
