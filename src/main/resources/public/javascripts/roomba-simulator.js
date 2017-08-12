var roombaSim = angular.module('roombaSimApp', ['ui.codemirror']);
roombaSim.controller('roombaSimController', function($scope)
{
$scope.sayHello = function() {window.alert("Hello") };
$scope.editorOptions = {
	lineWrapping: true,
	lineNumbers: true,
	matchBrackets: true,
	mode: 'text/x-java'
};
$scope.code = '';
});
