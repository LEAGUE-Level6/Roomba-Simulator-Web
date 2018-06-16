// The maze is slightly harder now. 
//
// Use the turnRight() and the turnLeft() methods. Improve the turnLeft()
// method so that it does not simply turnRight() 3 times.
// 
// curveLeft() and curveRight() will not be provided. 
// 
// Try to see what each of them do and write a program that solves the maze!

void setup() { 
	println("userSetup()"); 
} 

void roboLoop() { 
	//Call your method here
    println("roboLoop()"); 
}

//da methods
void moveForward(){
	driveDirect(500,500);
	delay(1000); 
}

void turnRight(){
	driveDirect(250,-250);
	delay(1650);
}

void turnLeft(){
	turnRight();
	turnRight();
	turnRight();
}