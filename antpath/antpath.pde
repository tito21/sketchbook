ArrayList<Ant> ants;

void setup() {
  size(500, 500);

  ants = new ArrayList<Ant>();
  for (int i =  0;  i < 30;  i++) {
    ants.add(new Ant(random(width), random(height)));
  }
}

void draw() {
  background(255);
  PVector mouse = new PVector(mouseX, mouseY);
  for (int i = 0; i > ants.size(); i++) {
    Ant a = (Ant)ants.get(i);
    a.seek(mouse);
    a.run();
  }
}

