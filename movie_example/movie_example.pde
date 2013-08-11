import processing.video.*;
//import org.json.*;
//import controlP5.*;


Movie myMovie;
PFont f;
int i;
JSONArray quantifiedDatabase;


void setup() {
  size(640+200, 480+200);
  //myMovie = new Movie(this, "totoro.mov");
  //myMovie = new Movie(this, "/Applications/iMovie.app/Contents/Resources/Filmstrip.mov");
  //myMovie = new Movie(this, "/System/Library/Compositions/Yosemite.mov");
 
  quantifiedDatabase = loadJSONArray("data/json_example.json");


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
  
  // read the value for truth for the slider
  int sliderTruthValue = 5;
  int sliderTimeValue = 1;
  
  textFont(f);

  for(i=0; i<quantifiedDatabase.size(); i++) {
    JSONObject infoChunk = quantifiedDatabase.getJSONObject(i);
    int truthValue = infoChunk.getInt("truth");
    int timeValue = infoChunk.getInt("time");
    
    // compare truthValue to slidervalue
   float distance = sqrt(sq(truthValue - sliderTruthValue) + sq(timeValue - sliderTimeValue));
   if(distance < 4) {
     textAlign(CENTER);
     text(infoChunk.getString("info"), width/2, height/2);
     //text("Bla " + nf(i, 0), width/2, height/2);
      //i = i + 1;

   }
  }
}

