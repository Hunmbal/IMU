#include <Wire.h>

#define IMU 0x68
#define PWR_MGMT_1_REG 0x6B

#define ACCEL_XOUT_H 0x3B
#define GYRO_XOUT_H 0x43

#define SDA_PIN 21
#define SCL_PIN 22

#define samples 10000
int16_t arrX[samples];
int16_t arrY[samples];
int16_t arrZ[samples];
int i = 0;

void setup() {
  Wire.begin();
  Serial.begin(9600);


  // Wake up the MPU9250
  Wire.beginTransmission(IMU);
  Wire.write(PWR_MGMT_1_REG);
  Wire.write(0);
  Wire.endTransmission();
}




void loop() {
  int16_t avgZ,avgX,avgY;
  // Read accelerometer data
  float accelX = readRegister16(IMU, ACCEL_XOUT_H);     //* 9.81 / 16600;
  float accelY = readRegister16(IMU, ACCEL_XOUT_H + 2); //* 9.81 / 16400;
  float accelZ = readRegister16(IMU, ACCEL_XOUT_H + 4); //* 9.81 / 17700;
  //float mag = sqrt(accelX*accelX + accelY*accelY + accelZ*accelZ);


 
  // arrX[i] = accelX;
  // arrY[i] = accelY; 
  // arrZ[i] = accelZ;

  // i++;
  // if (i==samples) {
  //   i=0;
  // }
  // avgX = calcAvg(arrX);
  // avgY = calcAvg(arrY);
  // avgZ = calcAvg(arrZ);
  

 
  // if( i%200==0)
  // {
  // Print accelerometer data
  Serial.print((accelX));  Serial.print(",");
  Serial.print((accelY));  Serial.print(",");
  Serial.print((accelZ));  Serial.print("\n");
 // Serial.print((mag));     Serial.print("\n");

  //Serial.println("\n\n");
  // }
  delay(1);
}



int16_t calcAvg(int16_t *temparr) {
  int n = 0;
  int sum = 0;
  for (int j = 0; j < samples ; j++) {
    if (temparr[j] != NULL) {
      sum = temparr[j] + sum;
      n++;
    } 
  }
  int16_t average= sum/n;
  return average;


}

// Read MPU registers
int16_t readRegister16(int addr, int reg) {
  Wire.beginTransmission(addr);
  Wire.write(reg);
  Wire.endTransmission(false);
  Wire.requestFrom(addr, 2, true);
  
  int16_t value = Wire.read() << 8 | Wire.read();
  return value;
}

