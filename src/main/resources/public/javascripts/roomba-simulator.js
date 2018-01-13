var roombaSim = angular.module('roombaSimApp', [ 'ui.codemirror' ]);

function processingLoaded() {
	var p = Processing.getInstanceById('sketch');
	if (typeof (simulatorInit) === 'function') {
		simulatorInit(p);
	}
}
function onProcessingLoad(simulatorInitialization) {
	var p = Processing.getInstanceById('sketch');
	if (typeof (p) === 'object')
		simulatorInitialization(p);
	else
		simulatorInit = simulatorInitialization;
}

roombaSim.controller('roombaSimController', function($scope, $http, $window) {
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
	loadCode();
	
	var startCoord;
	var orientation;
	var pathName = $window.location.pathname;
	var maze = pathName.substring(pathName.lastIndexOf('/'));
	if (maze === '/levelRandom') {
		onProcessingLoad(function(p) {
			p.generateRandomMaze();
		});
	} else {
		$http({
			method : 'GET',
			url : '/mazes' + maze + '.json'
		}).then(
				function successCallback(response) {
					onProcessingLoad(function(p) {
						console.log(angular.toJson(response.data));
						var hPaths = response.data.horizontalPaths;
						var vPaths = response.data.verticalPaths;
						startCoord = response.data.start.coord;
						orientation = response.data.start.orientation;
						var finishCoord = response.data.finishCoord;

						for (var i = 0; i < hPaths.length; i++) {
							p.addHorizontalPath(hPaths[i].x, hPaths[i].y);
						}
						for (var j = 0; j < vPaths.length; j++) {
							p.addVerticalPath(vPaths[j].x, vPaths[j].y);
						}
						p.startingPointLocations(startCoord.x, startCoord.y,
								orientation);
						p.finishingPointLocation(finishCoord.x, finishCoord.y);
						p.setMaze();
					});

					// this callback will be called asynchronously
					// when the response is available
				}, function errorCallback(response) {
					var p = Processing.getInstanceById('sketch');

					console.log(response.status);
					console.log(JSON.stringify(response));
					// called asynchronously if an error occurs
					// or server returns response with an error status.
				});
	}

	$scope.editorOptions = {
		lineWrapping : true,
		lineNumbers : true,
		matchBrackets : true,
		mode : 'text/x-java'
	};
	
	function saveCode()
	{
		console.log($scope.code);
		$window.localStorage.setItem($window.location.pathname, $scope.code);
		
	}
	function loadCode()
	{
		var code = $window.localStorage.getItem($window.location.pathname);
		if (code!=null)
		{
			$scope.code = code
		}
		console.log($scope.code);
		
	}

	

	
	$scope.runSimulation = function() {
	    saveCode();
		var processingCode = $scope.code;
		var jsCode = Processing.compile(processingCode).sourceCode;
		var func = eval(jsCode);
		var p = Processing.getInstanceById('sketch');

		// using a dedicated method to call draw in processing then using that
		// method in java script

		driveDirect = p.driveDirect;

		if (!p.simulationDraw) {
			p.simulationDraw = p.draw;
		}

		func(p);

		p.resetTimer();

		p.startingPointLocations(startCoord.x, startCoord.y, orientation);

		p.setup();
		p.draw = function() {
			p.simulationDraw();
			p.roboLoop();
		}

		console.log(p.draw);
		console.log(jsCode);
		console.log();

	};
});
