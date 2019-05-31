// code for rube goldberg, won't do much without a structure
#include <Servo.h>
Servo servo1;
int srv = 0; // standard servo
int phtrsstr = 0; //photoresistor
int led = 1;
int lightCal;
int lightVal;
void setup() {
  // photoresistor is on an analog pin and does not need to be set
  pinMode(srv, OUTPUT);
  pinMode(led, OUTPUT);
  servo1.attach(srv);
  lightCal = analogRead(phtrsstr);
}
void loop() {
  st();
  pr();
}
void st() {
  //START
  servo1.write(180);
  delay(500);
  servo1.write(0);
}
void pr() {
  //Light an LED at the end
  lightVal = analogRead(phtrsstr);
  if (lightVal < lightCal - 10) {
    digitalWrite(1, HIGH);
  }
}
