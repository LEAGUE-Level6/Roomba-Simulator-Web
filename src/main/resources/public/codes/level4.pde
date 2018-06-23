//The maze is much more complex in this level.
//
//To help you navigate this map, you have been given 
//the turnRight() and the turnLeft() methods like before.
//
//Have fun!

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

void moveForwardToEnd(){
	boolean collide = false;
	while(!collide){
		moveForward();
		if(isBumpRight() || isBumpLeft()){
			driveDirect(-500,-500);
			delay(1000); 
			collide = true;
		}
	}
}

void turnRight(){
	driveDirect(250,-250);
	delay(1650);
}

void turnLeft(){
    driveDirect(-250,250);
	delay(1650);
}