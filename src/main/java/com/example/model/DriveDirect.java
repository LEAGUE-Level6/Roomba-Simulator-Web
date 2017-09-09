package com.example.model;

public class DriveDirect extends Command {
	int leftVelocity = 0;
	int rightVelocity = 0;

	@Override
	public String getCommand() {
		// TODO Auto-generated method stub
		return "driveDirect";
	}

	public int getLeftVelocity() {
		return leftVelocity;
	}

	public int getRightVelocity() {
		return rightVelocity;
	}

	public void setLeftVelocity(int x) {
		leftVelocity = x;
	}

	public void setRightVelocity(int x) {
		rightVelocity = x;
	}

}
