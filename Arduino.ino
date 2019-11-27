void setup() {
  Serial.begin(9600);
}

void loop() {
  int sensor1 = analogRead(A0);
  int sensor2 = digitalRead(8);

  // keep this format
  Serial.print(sensor1);
  Serial.print(",");  // put comma between sensor values
  Serial.print(sensor2);
  //Serial.print(",");
  //Serial.print(sensor3);
  Serial.println(); // add linefeed after sending the last sensor value

  // too fast communication might cause some latency in Processing
  // this delay resolves the issue.
  delay(10);
}
