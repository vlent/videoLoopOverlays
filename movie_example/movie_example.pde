import processing.video.*;
import controlP5.*;


ControlP5 cp5;
Movie myMovie;
PFont f;
JSONArray quantifiedDatabase;

//**********************************

String[] sliderNames = { "time", "attitude", "truth", "privacy", "intensity" };
float [] sliderValues = { 0, 0, 0, 0, 0 };
int numberOfSliders = 5;

//**********************************


void setup() {
  size(640+ 300, 480+300);
  quantifiedDatabase = loadJSONArray("overlayDatabase.json");
  myMovie = new Movie(this, "Yosemite.mov");

  background(30, 30, 30);
  myMovie.loop();

  f = createFont("Arial", 15, true);

  //************Setup stuff for sliders**********************
  cp5 = new ControlP5(this);

  for(int i=0; i<numberOfSliders; i++){

     cp5.addSlider(sliderNames[i])
       //.setPosition(width*(i+1)/5-75,height-255)  //location in window
       .setPosition(640*(i+1)/5-75,height-255)  //location in window
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

  background(30, 30, 30);
  image(myMovie, 0, 0);


  //***************slider stuff*******************
  //positions and reads out the slider values
  //this will become a dark filter over the entire video
  //fill(255-attitude*20);
  //rect(width*2/5-90,330,50,50);

  //for (int j=0; j<numberOfSliders; j++) {
  // println("the " + sliderNames[j] + " slider is at " + cp5.getController(sliderNames[j]).getValue()); 
  //}
 //**********************************

  textFont(f);

  for(int i=0; i<quantifiedDatabase.size(); i++) {
    JSONObject infoChunk = quantifiedDatabase.getJSONObject(i);
    int[] chunkValues = new int[numberOfSliders];

    float sumSquares = 0;
    for(int j=0; j<numberOfSliders; j++) {
      chunkValues[j] = infoChunk.getInt(sliderNames[j]);
      sliderValues[j] = cp5.getController(sliderNames[j]).getValue();
      sumSquares += sq(chunkValues[j] - sliderValues[j]);
    }
    float distance = sqrt(sumSquares);

   if(distance < 3) {
     textAlign(CENTER);
    // text(infoChunk.getString("info"), width/2, height/2);
     textSize(14);
     fill(100);
     //text(infoChunk.getString("info"), width/2+random(-width/3, width/3), height/2+random(-height+10, height-100), 70, 100);
     text(infoChunk.getString("info"), 650, random(50, 200), 70, 100);
     //text("Bla " + nf(i, 0), width/2, height/2);
      //i = i + 1;

   }
  }
}
