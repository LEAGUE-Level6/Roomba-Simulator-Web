// Now you will have to study a little bit because
// you have to turn in this level. 
// To help you out, two methods have been provided:
// turnRight() and moveForward()
//
// Call (and use) a method by typing the method name 
// followed by a "()".
//
// Try to understand how the methods provided work. 
//
// Write your code in roboLoop(). 


void setup() { 
	println("userSetup()"); 
} 

void roboLoop() { 
	//Your code goes here!
	
}

//the methods
void moveForward(){
	driveDirect(500,500);
	delay(1000);
}

void turnRight(){
	driveDirect(250,-250);
	delay(1650);
}