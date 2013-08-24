ArrayList<Boid> sis;

void setup() {
  size(500, 200);
  sis = new ArrayList();
  sis.add(new Boid(random(width),random(height)));
}

void draw() {
  for (int i = 0; i < sis.size(); i++) {
    Boid b = (Boid) sis.get(i); //<>//
    b.display();
    b.update();
    b.run();
  }
  if (mousePressed) {
    sis.add(new Boid(mouseX, mouseY));
  }
  background(255);
}
