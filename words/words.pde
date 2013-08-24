String lines[];

String words[];

void setup() {
  size(500, 500);
  lines = loadStrings("ensayo.txt");
  if (lines == null) {
    println("an error occur tring to open your file");
  }
  else {
    setfile();
  }
}

void draw() {
}

void setfile() {
  for (int i=0; i<lines.length;  i++) {
    String pWords[] = splitTokens(lines[i], " "); 
    for (int j=pWords.length; j==0; j--) {
      words = append(pWords, pWords[j]);
      println (words);
    }
  }
}

