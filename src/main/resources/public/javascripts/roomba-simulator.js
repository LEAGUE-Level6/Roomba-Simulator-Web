var roombaSim = angular.module('roombaSimApp', [ 'ui.codemirror' ]);
var templateCode; 
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
	var startCoord;
	var orientation;
	var pathName = $window.location.pathname;
	var maze = pathName.substring(pathName.lastIndexOf('/'));
	$http({
		method: 'GET',
		url: '/codes' + maze + '.pde',
		transformResponse: [function (data) {
			return data;
		}]
	}).then(
		function successCallback(response) {
			templateCode= response.data;
			$scope.code = response.data;
			loadCode();
		},
		function errorCallback(response){
			
		}
	);
	if (maze === '/levelRandom') {
		onProcessingLoad(function(p) {
			p.setupRandomLevel();
		});
	} else {
		$http({
			method: 'GET',
			url: '/mazes' + maze + '.json'
		}).then(
			function successCallback(response) {
				onProcessingLoad(function(p) {
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
			},
			function errorCallback(response) {
				var p = Processing.getInstanceById('sketch');

				console.log(response.status);
				console.log(JSON.stringify(response));
			});
	}

	$scope.editorOptions = {
		indentUnit : 4,
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
			$scope.code = code;
		}
		
	}

	$scope.reset = function()
	{
		$scope.code = templateCode;
	}

	
	$scope.SaveAndRun = function() {
	    saveCode();
	    
		var processingCode = $scope.code;
		var jsCode = Processing.compile(processingCode).sourceCode;
		var p = Processing.getInstanceById('sketch');
		try {
			var func = eval(jsCode);
		} catch (err) {
			p.println(err);
		}

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
