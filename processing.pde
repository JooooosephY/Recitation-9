import processing.video.*; 

import processing.serial.*;

String myString = null;
Serial myPort;


int NUM_OF_VALUES = 2;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int[] sensorValues;      /** this array stores values from Arduino **/

Capture cam;
void setup() { 
  size(640, 480); 
  setupSerial();
  cam = new Capture(this, 640, 480);
  cam.start(); 
} 

void draw() { 
  if (cam.available()) { 
   cam.read(); 
  } 
  updateSerial();
  image(cam, 0, 0);
  filter(BLUR);
  filter(POSTERIZE, map(sensorValues[0],0,1023,2,25));
  if(sensorValues[1] == 1){
    filter(INVERT);
  }
  
}

void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);


  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[NUM_OF_VALUES];
}



void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
