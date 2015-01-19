import processing.serial.*;
import java.io.*;

Serial myPort;
String sentData = "";
int goodMessages = 0;
int badMessages = 0;
int sentCount = 0;
int recievedCount = 0;
int timer;

void setup() {

  size(500, 200); 
  println("Serial Echo Test");

  //Start serial comms and initialise
  boolean serial = startSerial();

  if (serial) {

    delay(1000);
    myPort.write(".");
    println("Serial connected");
  } else {
    println("Serial NOT connected");
  }
  delay(1000);
}

void draw() {
  
  background(0);
  
  if (millis() - timer >= 1000) {
    sendData();
    timer = millis();
//    println(randomString());
//    sentCount += 1;
  }
  
  textSize(32);
  fill(255);
  text("goodMessages", 10, 30);
  text("badMessages", 10, 60);
  text("sentCount", 10, 90);
  text("recievedCount", 10, 120);
  text(goodMessages, 300, 30);
  text(badMessages, 300, 60);
  text(sentCount, 300, 90);
  text(recievedCount, 300, 120);
}

void serialEvent (Serial myPort) {

  String inString = myPort.readStringUntil('\n');
  checkString(inString);
  recievedCount += 1;
}

void checkString(String inString) {

  if (inString.equals(sentData)) {
    goodMessages += 1;
  } else {
    badMessages += 1;
  }
}

void sendData() {

  String outputString = randomString();

  sentData = outputString;
  myPort.write(outputString);
  myPort.clear();
  println(outputString);
  sentCount += 1;
}

String randomString() {

  char[] chars = "abcdefghijklmnopqrstuvwxyz1234567890".toCharArray();

  String outputString = "";

  for (int i = 0; i < random (10, 30); i++) {
    outputString += chars[int(random(36))];
  }

  return outputString;
} 



//This function initiates the serial comms and returns state of connection
boolean startSerial() {

  println(Serial.list());

  if (Serial.list().length > 0) {
    myPort = new Serial(this, Serial.list()[0], 9600);
    println("Port [0] selected for comms");
    myPort.bufferUntil('\n');
    myPort.clear();

    return true;
  } else {
    return false;
  }
}
