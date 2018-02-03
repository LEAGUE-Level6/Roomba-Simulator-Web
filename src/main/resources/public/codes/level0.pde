//The green dot is where all your robot dreams come true. 
//Can you make the robot enter the green dot?
//Use the driveDirect(int,int) method to make your robot move
//driveDirect(int,int) takes in two parameters
//The left and right wheel power 
//But watch out they cannot dip below -500 or exceed 500
//Call this method in the roboLoop method
void setup() 
{ 
     println("userSetup()"); 
} 
void roboLoop() 
{ 
//Call your method here
    println("roboLoop()"); 
    driveDirect(270,500); 
}