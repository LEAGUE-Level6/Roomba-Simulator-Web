var roombaSim = angular.module('roombaSimApp', ['ui.codemirror']);
roombaSim.controller('roombaSimController', function($scope, $http)
{
$scope.sayHello = function() {window.alert("Hello") };
$scope.editorOptions = {
	lineWrapping: true,
	lineNumbers: true,
	matchBrackets: true,
	mode: 'text/x-java'
};
$scope.code = 
'void setup() \n' +
'{ \n' +
'} \n' +
'void roboLoop() \n' +
'{ \n' +
'}'; 


/*
'package org.jointheleague.ecolban.cleverrobot; \n '+ 
' \n ' +
'import java.io.IOException; \n' +
'import java.util.Random; ' +
' \n ' +
'import org.jointheleague.ecolban.rpirobot.IRobotAdapter; \n ' +
'import org.jointheleague.ecolban.rpirobot.IRobotInterface; \n' +
'import org.jointheleague.ecolban.rpirobot.SimpleIRobot; \n ' +
'  \n ' +
'public class CleverRobot extends IRobotAdapter { \n ' +
'	private boolean tailLight; \n ' +
'   private int loopsRemaining = 3; \n ' +
' 	\n ' +
' 	public CleverRobot(IRobotInterface iRobot) { \n ' +
' 		super(iRobot);\n ' +
' 	} \n ' +
' 	\n ' +
' 	public static void main(String[] args) throws Exception { \n ' +
'		IRobotInterface base = new SimpleIRobot(); \n ' +
'		CleverRobot rob = new CleverRobot(base); \n ' +
'		rob.setup(); \n ' +
'		while (rob.loop()) { \n ' +
'		} \n ' +
'		rob.shutDown(); \n ' +
'	} \n ' +
'\n ' +
'	private void setup() throws Exception { \n ' +
'\n ' +
'\n ' +
'\n ' +
'\n ' +
'	} \n ' +
'\n ' +
'	private boolean loop() throws Exception { \n ' +
'\n ' +
'\n ' +
'\n ' +
'		return true; \n ' +
'	} \n ' +
'\n ' +
'	private void shutDown() throws IOException { \n ' +
'		reset(); \n ' +
'		stop(); \n ' +
'		closeConnection(); \n ' +
'	} \n ' +
'} \n ' +
'\n '; */



$scope.runSimulation = function() {

var processingCode = $scope.code;
var jsCode = Processing.compile(processingCode).sourceCode;
var func = eval(jsCode); 
var p=Processing.getInstanceById('sketch');
console.log(p.getRoomba());
//using a dedicated method to call draw in processing then using that method in java script
callDraw = p.callDraw;
drawCircle = p.drawCircle;
driveDirect = p.driveDirect;


   func(p);
console.log(jsCode);
console.log();

};
});

