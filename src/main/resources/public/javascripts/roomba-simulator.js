var roombaSim = angular.module('roombaSimApp', [ 'ui.codemirror' ]);
var templateCode; 
var turn=0;
var w;
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
		viewportMargin: Infinity,
		mode : 'text/x-java'
	};
	
	function saveCode()
	{
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
		$window.localStorage.setItem($window.location.pathname, $scope.code);
	}

	
	$scope.saveAndRun = function() {
	
		
		
		turn =turn +1;
		saveCode();
		var p = Processing.getInstanceById('sketch');
		driveDirect = p.driveDirect;
		drive = p.drive;
		getUltrasonicDistance = p.getUltrasonicDistance;
		try {
			var jsCode = Processing.
				compile($scope.code).sourceCode;
				console.log(jsCode);
			var funNames = [];
			var re = /function +([^(]+)/g;
			var m;
			do{
				m = re.exec(jsCode);
				if(m){
					funNames.push(m[1]);
				}
			}while (m);
			jsCode = jsCode.
				replace(/\$p\.delay/g, 'await delay');
			for(var i = 0; i < funNames.length; ++i){
				var f = funNames[i];
				console.log(f);
				jsCode = jsCode.
					replace(new RegExp(f + '\\(', 'g'), 'await '+ f +'(').
					replace('function await ' + f, 'async function ' + f);
			}
			
			if(typeof(Worker)!=="undefined") {
				
				if(typeof(w)!=="undefined") {
					
					w.terminate();
				}
				w = new Worker("/javascripts/simulation-run-worker.js");
				w.postMessage(jsCode);
				
				w.onmessage = function(e) {
					switch(e.data.method){
						case "driveDirect":
							p.driveDirect(e.data.left, e.data.right);
							break;
						default: 
							console.log("Unknown Method: " + e.data.method);
					}
				}
			}
			
			
			console.log(jsCode);
			var applyUserCode = eval(jsCode);

			applyUserCode(p);

			p.resetTimer();

			p.startingPointLocations(startCoord.x, startCoord.y, orientation);
		} 
		catch (err) {
			p.println(err);
		}
	};
	
});

