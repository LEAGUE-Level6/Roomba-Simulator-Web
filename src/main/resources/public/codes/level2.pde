// To complete this level, you have to turn right. 
// The turnLeft() method on line __ currently turns right three times.
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

//da methods
void moveForward(){
	driveDirect(500,500);
	delay(1000);
	
}

void turnRight(){
	driveDirect(0,500);
	delay(300);
}

void turnLeft(){
	turnRight();
	turnRight();
	turnRight();
}