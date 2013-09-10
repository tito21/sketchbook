ArrayList<Ant> ants;
Map map;


void setup() {
  size(500, 500);
  map = new Map();
  ants = new ArrayList<Ant>();
  for (int i =  0;  i < 10;  i++) {
    ants.add(new Ant(random(-2, 2), random(-2, 2), map));
  }
}

void draw() {
  background(255);
  map.disp();
  //PVector mouse = new PVector(mouseX, mouseY);
  for (int i = 0; i < ants.size(); i++) {
    Ant a = (Ant)ants.get(i);
    //a.seek(mouse);
    a.run();
  }
}

