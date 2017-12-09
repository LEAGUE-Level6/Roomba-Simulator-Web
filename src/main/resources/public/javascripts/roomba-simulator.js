var roombaSim = angular.module('roombaSimApp', ['ui.codemirror']);
roombaSim.controller('roombaSimController', function($scope, $http) {
	
	$http({
	  method: 'GET',
	  url: '/mazes/level0.json'
	}).then(function successCallback(response) {
		console.log(response.data);
		var p = Processing.getInstanceById('sketch');
		p.setMaze();
	    // this callback will be called asynchronously
	    // when the response is available
	  }, function errorCallback(response) {
	  console.log(response.status);
	  console.log(JSON.stringify(response));
	    // called asynchronously if an error occurs
	    // or server returns response with an error status.
	  });
	
	$scope.editorOptions = {
		lineWrapping: true,
		lineNumbers: true,
		matchBrackets: true,
		mode: 'text/x-java'
	};
	$scope.code = 
	'void setup() \n' +
	'{ \n' +
	'   println("userSetup()"); \n' +
	'} \n' +
	'void roboLoop() \n' +
	'{ \n' +
	'  println("roboLoop()"); \n'+
	'  driveDirect(500,500); \n'+
	'}'; 
	
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
		getRoomba = p.getRoomba;
		
		
		
		
		p.simulationSetup = p.setup
		p.simulationDraw = p.draw
		func(p)
		p.userSetup = p.setup
	
	
		
		p.setup = function()
		{
			p.userSetup()
			p.simulationSetup()
		}
		p.draw = function()
		{
			p.println("draw()");
			p.simulationDraw()
			p.roboLoop()
		}
		
		
		console.log(p.simulationDraw)
		console.log(getRoomba())
		console.log(jsCode);
		console.log();

	};
});

