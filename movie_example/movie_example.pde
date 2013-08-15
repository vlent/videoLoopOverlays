import processing.video.*;
//import org.json.*;
import controlP5.*;
ControlP5 cp5;


Movie myMovie;
PFont f;
int i;
JSONArray quantifiedDatabase;

//**********************************

String[] sliderNames = {"timePeriod", "attitude", "truth", "privacy", "intensity"};
int timePeriod = 0;  //the first slider's starting value
int attitude = 0;
int truth = 0;
int privacy = 0;
int intensity = 0;
int numberOfSliders = 5;

//**********************************


void setup() {
  size(640+ 0, 480+300);
  //myMovie = new Movie(this, "totoro.mov");
  //myMovie = new Movie(this, "/Applications/iMovie.app/Contents/Resources/Filmstrip.mov");
  //myMovie = new Movie(this, "/System/Library/Compositions/Yosemite.mov");
 
  quantifiedDatabase = loadJSONArray("data/overlayDatabase.json");


  myMovie = new Movie(this, "Yosemite.mov");


  myMovie.loop();
  
  f = createFont("Arial", 15, true);
  
  i = 0;
  
  //************Setup stuff for sliders**********************
  cp5 = new ControlP5(this);
  
  for(int i=0; i<numberOfSliders; i++){
    
     cp5.addSlider(sliderNames[i])
       .setPosition(width*(i+1)/5-75,height-255)  //location in window
       .setSize(20,200)              //size of slider
       .setRange(1,10)                //range of tick marks
       .setNumberOfTickMarks(10)      //number of tick marks
       .setSliderMode(Slider.FLEXIBLE) //this gives it an arrow
       ;
     
    cp5.getController(sliderNames[i]).getCaptionLabel().align(ControlP5.CENTER, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  }
  //**********************************
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
  
  
  //***************slider stuff*******************
  //positions and reads out the slider values
  //this will become a dark filter over the entire video  
  fill(255-attitude*20);
  rect(width*2/5-90,330,50,50);
 
  for (int j=0; j<numberOfSliders; j++){ 
   println("the " + sliderNames[j] + " slider is at " + cp5.getController(sliderNames[j]).getValue()); 
  }
 //**********************************
  
  
  
  textFont(f);

  for(i=0; i<quantifiedDatabase.size(); i++) {
    JSONObject infoChunk = quantifiedDatabase.getJSONObject(i);
    int truthValue = infoChunk.getInt("truth");
    int timeValue = infoChunk.getInt("time");
    
    // compare truthValue to slidervalue
    float sliderTruthValue = cp5.getController(sliderNames[2]).getValue();
    float sliderTimeValue = cp5.getController(sliderNames[0]).getValue();
    
   float distance = sqrt(sq(truthValue - sliderTruthValue) + sq(timeValue - sliderTimeValue));

   if(distance < 3) {
     textAlign(CENTER);
    // text(infoChunk.getString("info"), width/2, height/2);
     textSize(14);
     fill(50);
     text(infoChunk.getString("info"), width/2+random(-width/3, width/3), height/2+random(-height+10, height-100), 70, 100);
     //text("Bla " + nf(i, 0), width/2, height/2);
      //i = i + 1;

   }
  }
}

