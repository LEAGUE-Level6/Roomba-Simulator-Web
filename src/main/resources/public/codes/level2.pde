// To complete this level, you have to turn left. 
// The turnLeft() method on line 28 currently turns right three times.
// Can you improve the turnRight method?
//
// Again, write your code in roboLoop(). 

void setup() { 
	println("userSetup()"); 
} 

void roboLoop() { 
	//Your code goes here!
	moveForward();
	turnRight();
}

//the methods
void moveForward(){
	driveDirect(500,500);
	delay(1250);
}

void turnRight(){
	driveDirect(250,-250);
	delay(2150);
}

void turnLeft(){
	turnRight();
	turnRight();
	turnRight();
}