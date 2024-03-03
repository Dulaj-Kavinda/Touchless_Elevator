#include <Stepper.h> // Include the header file

#define STEPS 32 //number of steps of motor

int pushbutton_pins[]={1,2,3,4,5,6,7,8,9,10,11};
// pins 1,2 = door open and close, pins 3,4,5 = inner panel buttons, pins 6,7,8 = up

int ledPin_1 = 12; // choose the pin for the LED in opening door
int ledPin_2 = 13; // choose the pin for the LED in closing door

int Lswitch_1 = 14; // choose the pin for the limit switch
int Lswitch_2 = 15; 
int Lswitch_3 = 16; 

Stepper stepper(STEPS, 17, 18, 19, 20);//(STEPS, 8, 10, 9, 11)choose pins for stepper   

int ele_status=1;
int val=0;
int way=0;

void setup() {
  for(int i=0;i<11;i++){
    pinMode(pushbutton_pins[i],INPUT);
  }
  pinMode(ledPin_1, OUTPUT);
  pinMode(ledPin_2, OUTPUT);
  
  pinMode(Lswitch_1, INPUT); 
  pinMode(Lswitch_2, INPUT); 
  pinMode(Lswitch_3, INPUT); 

  stepper.setSpeed(200);
}

void loop() {
  for(int i=0 ; i<11 ; i++){
    checkPush (pushbutton_pins[i]);
  }
}

void checkPush(int pinNumber)
{
  int pushed = digitalRead(pinNumber);  // read input value
  if (pushed == HIGH){ // check if the input is HIGH (button released)
    if(pinNumber==pushbutton_pins[0] || pinNumber==pushbutton_pins[1]){
      if(pinNumber==1){
        digitalWrite(ledPin_1,HIGH);
      }else{
        digitalWrite(ledPin_2,HIGH);
      }
    }else{
      switch(ele_status){
        case 1:
          if(pinNumber==pushbutton_pins[3] || pinNumber==pushbutton_pins[6]|| pinNumber ==pushbutton_pins[9]){
            val=300;
            stepper.step(val);
            ele_status = 2;
          }else if(pinNumber==pushbutton_pins[4] || pinNumber==pushbutton_pins[7] || pinNumber ==pushbutton_pins[10]){
            val=600;
            stepper.step(val);
            ele_status = 3;
          }
          way=0;//up
          break;
        case 2:
          if((pinNumber==pushbutton_pins[2] || pinNumber==pushbutton_pins[5] || pinNumber ==pushbutton_pins[8])&&(way=1)){
            val=-300;
            stepper.step(val);
            ele_status =1;
            way=0;
          }else if((pinNumber==pushbutton_pins[4] || pinNumber==pushbutton_pins[7] || pinNumber ==pushbutton_pins[10])&&(way=0)){
            val=300;
            stepper.step(val);
            ele_status=3;
            way=1;
          }
          break;
        case 3:
          if(pinNumber==pushbutton_pins[3] || pinNumber==pushbutton_pins[6] || pinNumber == pushbutton_pins[9]){
            val=-300;
            stepper.step(val);
            ele_status =2;
          }else if(pinNumber==pushbutton_pins[2] || pinNumber==pushbutton_pins[5] || pinNumber ==pushbutton_pins[8]){
            val=-600;
            stepper.step(val);
            ele_status=1;
          }
          way=1;//down
          break;
      }
    }
    
  }
}
