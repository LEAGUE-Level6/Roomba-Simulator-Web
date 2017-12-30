var roombaSim = angular.module('roombaSimApp', ['ui.codemirror']);

roombaSim.controller('roombaSimController', function($scope, $http, $window) {
	var startCoord;
	var orientation;
	$http({
	  method: 'GET',
	  url: '/mazes' + $window.location.pathname + '.json'
	}).then(function successCallback(response) {
		console.log(angular.toJson(response.data));
		var hPaths = response.data.horizontalPaths;
		var vPaths = response.data.verticalPaths;
		startCoord = response.data.start.coord;
		orientation = response.data.start.orientation;
		var finishCoord = response.data.finishCoord;
		var p = Processing.getInstanceById('sketch');
		for(var i = 0; i< hPaths.length; i++)
		{
			p.addHorizontalPath(hPaths[i].x, hPaths[i].y);
		}
		for(var j = 0; j < vPaths.length; j++)
		{
			p.addVerticalPath(vPaths[j].x, vPaths[j].y);
		}
		p.startingPointLocations(startCoord.x, startCoord.y, orientation);
		p.finishingPointLocation(finishCoord.x, finishCoord.y);
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
	
	function saveCode()
	{
		
		localStorage.setItem($window.location.pathname, code);
		
	}
	function loadCode()
	{
		var $window.location.pathname = localstorage.getItem($window.location.pathname);
	}
	
	$scope.runSimulation = function() {
	    saveCode();
		var processingCode = $scope.code;
		var jsCode = Processing.compile(processingCode).sourceCode;
		var func = eval(jsCode); 
		var p=Processing.getInstanceById('sketch');
	
		//using a dedicated method to call draw in processing then using that method in java script
		
	
		driveDirect = p.driveDirect;
		
		
		
		


		if(!p.simulationDraw ) 
		{	
			p.simulationDraw = p.draw  
		}

			
		
		
		func(p)
	
		p.startingPointLocations(startCoord.x, startCoord.y, orientation);

		p.setup()
		p.draw = function()
		{
			p.simulationDraw()
			p.roboLoop()
		}
			
	
		console.log(p.draw)
		console.log(jsCode);
		console.log();

	};
});

