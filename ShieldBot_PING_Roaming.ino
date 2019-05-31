// Summary: Pauses to check surroundings, then moves away from obstacles. If no obstacles, then go forward.
// DONE
#include <Servo.h>                           // Include servo library
const int rcheck = 2; // LEFT INDICATE LED. Place this LED on the bot's right.
const int lcheck = 3; // RIGHT INDICATE LED. Place this LED on the bot's left.
const int pingPin = 7; // this constant won't change. It's the pin number of the sensor's output.
const long closeRangeInch = 4; // object is this amount of inches away or less to be considered when picking direction
const int movementTime = 750; // time to move after each check (ms)
Servo pingPivot; // Declare standard servo
Servo servoLeft;                             // Declare left and right servos
Servo servoRight;
void setup() {
  Serial.begin(9600);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  tone(4, 3000, 1000);                       // Play tone for 1 second
  delay(1000);                               // Delay to finish tone
  pingPivot.attach(11); // Attach to pin 11
  // test
  /* pingPivot.writeMicroseconds(0);
    delay(1000);
    pingPivot.writeMicroseconds(1500);
    delay(1000);
    pingPivot.writeMicroseconds(3000); */
}
void loop() {
  int dirCheck1 = checkDirection(1);
  int dirCheck2 = checkDirection(2);
  int dirCheck3 = checkDirection(3);
  servoLeft.attach(13);                      // Attach left signal to pin 13
  servoRight.attach(12);                     // Attach right signal to pin 12
  if ((dirCheck1 == 1) && (dirCheck2 == 1) && (dirCheck3 == 1)) { // object on left / ahead / right
    Serial.println("BACKWARD");
    maneuver(-200, -200, movementTime);
    // keep out of infinite loop
    long decide = random(1, 2); // 1 LEFT, 2 RIGHT
    if (decide == 1) {
      Serial.println("LEFT");
      maneuver(-200, 200, movementTime); // LEFT
    }
    if (decide == 2) {
      Serial.println("RIGHT");
      maneuver(200, -200, movementTime); // RIGHT
    }
  }
  if ((dirCheck1 == 1) && (dirCheck2 == 1) && (dirCheck3 == 0)) { // object on left / ahead
    Serial.println("RIGHT");
    maneuver(200, -200, movementTime);
  }
  if ((dirCheck1 == 1) && (dirCheck2 == 0) && (dirCheck3 == 0)) { // object on left
    Serial.println("RIGHT");
    maneuver(200, -200, movementTime);
  }
  if ((dirCheck1 == 0) && (dirCheck2 == 1) && (dirCheck3 == 1)) { // object on ahead / right
    Serial.println("LEFT");
    maneuver(-200, 200, movementTime); // LEFT
  }
  if ((dirCheck1 == 1) && (dirCheck2 == 0) && (dirCheck3 == 1)) { // object on left / right
    Serial.println("FORWARD");
    maneuver(200, 200, movementTime);
  }
  if ((dirCheck1 == 0) && (dirCheck2 == 0) && (dirCheck3 == 1)) { // object on right
    Serial.println("LEFT");
    maneuver(-200, 200, movementTime); // LEFT
  }
  if ((dirCheck1 == 0) && (dirCheck2 == 1) && (dirCheck3 == 0)) { // object on ahead
    long decide = random(1, 2); // 1 LEFT, 2 RIGHT
    if (decide == 1) {
      Serial.println("LEFT");
      maneuver(-200, 200, movementTime); // LEFT
    }
    if (decide == 2) {
      Serial.println("RIGHT");
      maneuver(200, -200, movementTime); // RIGHT
    }
  }
  if ((dirCheck1 == 0) && (dirCheck2 == 0) && (dirCheck3 == 0)) { // no nearby objects
    Serial.println("FORWARD");
    maneuver(200, 200, movementTime);
  }
  servoLeft.detach();
  servoRight.detach();
}
int checkDirection(int direct) {
  // DIRECT: 1 = LEFT | 2 = FRONT | 3 = BACK
  int obstacle = 0;
  if (direct == 1) {
    digitalWrite(lcheck, HIGH);
    pingPivot.write(180);
    delay(500);
  }
  if (direct == 2) {
    digitalWrite(lcheck, HIGH);
    digitalWrite(rcheck, HIGH);
    pingPivot.write(90);
  }
  if (direct == 3) {
    digitalWrite(rcheck, HIGH);
    pingPivot.write(0);
  }
  delay(500);
  long prox = getPing();
  if (prox <= closeRangeInch) {
    tone(4, 1500, 100);                       // Play tone for 1 second
    delay(100);                               // Delay to finish tone
    obstacle = 1;
  }
  digitalWrite(lcheck, LOW);
  digitalWrite(rcheck, LOW);
  Serial.println(obstacle);
  return obstacle;
}
long microsecondsToInches(long microseconds) {
  // According to Parallax's datasheet for the PING))), there are 73.746
  // microseconds per inch (i.e. sound travels at 1130 feet per second).
  // This gives the distance travelled by the ping, outbound and return,
  // so we divide by 2 to get the distance of the obstacle.
  // See: http://www.parallax.com/dl/docs/prod/acc/28015-PING-v1.3.pdf
  return microseconds / 74 / 2;
}
long microsecondsToCentimeters(long microseconds) {
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the object we
  // take half of the distance travelled.
  return microseconds / 29 / 2;
}
long getPing() {
  // establish variables for duration of the ping, and the distance result
  // in inches and centimeters:
  long duration, inches, cm;
  // The PING))) is triggered by a HIGH pulse of 2 or more microseconds.
  // Give a short LOW pulse beforehand to ensure a clean HIGH pulse:
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);
  // The same pin is used to read the signal from the PING))): a HIGH pulse
  // whose duration is the time (in microseconds) from the sending of the ping
  // to the reception of its echo off of an object.
  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);
  // convert the time into a distance
  inches = microsecondsToInches(duration);
  cm = microsecondsToCentimeters(duration);
  Serial.print(inches);
  Serial.print("in, ");
  Serial.print(cm);
  Serial.print("cm");
  return inches;
}
void maneuver(int speedLeft, int speedRight, int msTime)
{
  // speedLeft, speedRight ranges: Backward  Linear  Stop  Linear   Forward
  //                               -50      -100......0......100       50
  servoLeft.writeMicroseconds(1500 + speedLeft);   // Set left servo speed
  servoRight.writeMicroseconds(1500 - speedRight); // Set right servo speed
  if (msTime == -1)                                // if msTime = -1
  {
    servoLeft.detach();                            // Stop servo signals
    servoRight.detach();
  }
  delay(msTime);                                   // Delay for msTime
}

