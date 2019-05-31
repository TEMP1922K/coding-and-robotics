// Coreographed lights for Super Mario Bros. Underground
// Open source
// Made for Arduino 101
const int breakMs = 1000; // ms between first and second, second and third, third and fourth, and fourth and fifth part of music
const int breakMsB = 1250; // ms between loops
const int ledPins[] = {1, 2, 3, 4, 5, 6}; // pins in use for LEDs. When building a circuit for this code, line up the LEDs in order by pin.
const int shortMs = 150; // ms between each beat
const double speed = 1.0; // change the speed. 1.0 is normal.
void setup() {
  int i;
  for (i = 0; i <= 5; i++) {
    pinMode(ledPins[i], OUTPUT); // all LEDs, all OUTPUT
  };
};
void loop() {
  int i;
  for (i = 0; i <= 1; i++) {
    sixBeatA();
    sixBeatB();
  }
  for (i = 0; i <= 44; i++) {
    blink();
  }
  delay(breakMsB * speed);
};
void blink() {
  int index;
  int delayTime = 25;
  for (index = 0; index <= 2; index++) {
    digitalWrite(ledPins[index], HIGH);
    digitalWrite(ledPins[index + 3], HIGH);
    delay(delayTime * speed);
    digitalWrite(ledPins[index], LOW);
    digitalWrite(ledPins[index + 3], LOW);
  }
};
void sixBeatA() {
  // this is for the first sequence, which plays twice
  digitalWrite(ledPins[0], HIGH);
  delay(shortMs * speed);
  digitalWrite(ledPins[2], HIGH);
  delay(shortMs * speed);
  digitalWrite(ledPins[1], HIGH);
  delay(shortMs * speed);
  digitalWrite(ledPins[5], HIGH);
  delay(shortMs * speed);
  digitalWrite(ledPins[4], HIGH);
  delay(shortMs * speed);
  digitalWrite(ledPins[3], HIGH);
  delay(shortMs * speed);
  delay(breakMs * speed);
};
void sixBeatB() {
  // this is for the second sequence, which plays twice
  digitalWrite(ledPins[0], LOW);
  delay(shortMs * speed);
  digitalWrite(ledPins[2], LOW);
  delay(shortMs * speed);
  digitalWrite(ledPins[1], LOW);
  delay(shortMs * speed);
  digitalWrite(ledPins[5], LOW);
  delay(shortMs * speed);
  digitalWrite(ledPins[4], LOW);
  delay(shortMs * speed);
  digitalWrite(ledPins[3], LOW);
  delay(shortMs * speed);
  delay(breakMs * speed);
};

