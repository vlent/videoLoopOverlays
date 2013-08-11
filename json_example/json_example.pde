//import org.json.*;  //json4processing

String sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting"
                    +" industry. Lorem Ipsum has been the industry's standard dummy text"
                    +" ever since the 1500s, when an unknown printer took a galley of type"
                    +" and scrambled it to make a type specimen book. It has survived not"
                    +" only five centuries, but also the leap into electronic typesetting,"
                    +" remaining essentially unchanged. It was popularised in the 1960s"
                    +" with the release of Letraset sheets containing Lorem Ipsum passages,"
                    +" and more recently with desktop publishing software like Aldus"
                    +" PageMaker including versions of Lorem Ipsum.";
String[] sampleWords = splitTokens(sampleText);

String[] dimensionNames = splitTokens("time attitude truth privacy intensity");

int randomValue() {
  return int(random(10))+1;
}

String randomWords() {
  int len, start, count;
  len = sampleWords.length;
  start = int(random(len));
  count = int(random(len-start-1))+1;
  return join(subset(sampleWords, start, count), " ");
}

void setup() {
  int n = 8;
  int d = 5;
  int i, j;
  //JSON arr = JSON.createArray();  //json4processing
  JSONArray arr = new JSONArray();
  for(i=0; i<n; i++) {
    //JSON obj = JSON.createObject();  //json4processing
    JSONObject obj = new JSONObject();
    for(j=0; j<d; j++) {
      //obj.setInt("prop"+nf(j, 0), randomValue());
      obj.setInt(dimensionNames[j], randomValue());
    }
    obj.setFloat("x", random(1.0));
    obj.setFloat("y", random(1.0));
    obj.setString("info", randomWords());
    arr.append(obj);
  }

  println( arr );
  saveJSONArray(arr, "data/json_example.json");
}

