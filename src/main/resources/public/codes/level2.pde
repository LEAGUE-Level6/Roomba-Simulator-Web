// To complete this level, you will curveLeft() 
// and curveRight() instead of turn. 
// 
// We will revisit the turning methods in level 3. 
// 
// Try to figure out how the curving methods work. 
//
// Again, write your code in roboLoop(). 

void setup() { 
	println("userSetup()"); 
} 

void roboLoop() { 
	//Your code goes here!
	
}

//the methods
void moveForward(){
	driveDirect(500,500);
	delay(1300);
}

void curveLeft(){
	driveDirect(350,500);
	delay(1800);
}

void curveRight(){
	driveDirect(500,350);
	delay(1800);
}