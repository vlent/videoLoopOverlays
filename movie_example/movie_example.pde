import processing.video.*;
import org.json.*;
import controlP5.*;


Movie myMovie;
PFont f;
int i;

void setup() {
  size(640+200, 480+200);
  //myMovie = new Movie(this, "totoro.mov");
  //myMovie = new Movie(this, "/Applications/iMovie.app/Contents/Resources/Filmstrip.mov");
  //myMovie = new Movie(this, "/System/Library/Compositions/Yosemite.mov");
  myMovie = new Movie(this, "Yosemite.mov");


  myMovie.loop();
  
  f = createFont("Arial", 20, true);
  
  i = 0;
}

//void draw() {
//  image(myMovie, 0, 0);
//}

//void movieEvent(Movie m) {
//  m.read();
//}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }
  
  image(myMovie, 0, 0);
  
  textFont(f);
  textAlign(CENTER);
  text("Bla " + nf(i, 0), width/2, height/2);
  i = i + 1;
}

