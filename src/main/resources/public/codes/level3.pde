// The maze is slightly harder now. 
// This level will not provide the turnLeft() and turnRight() methods,
// but if you wish, you can get them from level 2. 
// 
// Instead, the new methods provided in this level are  curveTopLeft(), 
// curveTopRight(), curveBottomLeft(), and curveBottomRight(). 
//
// Try to see what each of them do and write a program that solves the maze!

void setup() { 
	println("userSetup()"); 
} 

void roboLoop() { 
	//Call your method here
    println("roboLoop()"); 
    driveDirect(500,500);
}

//da methods
void moveForward(){
	driveDirect(500,500);
	delay(1000); 
}

void curveTopLeft(){
	driveDirect(0,500);
	delay(300);
}