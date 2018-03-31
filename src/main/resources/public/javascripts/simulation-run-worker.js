var jsCode;
onmessage = function(e)
{
	jsCode = e.data;
	//console.log(jsCode);
	printCode();
	runCode();
	
}

function printCode()
{

var userCode = eval(jsCode);

console.log(userCode);
setTimeout(printCode, 5000);

}
function driveDirect()
{
	console.log("driveDirect");
}
async function runSimulation(p){
	//var t = myTurn;
	
	try {
		await p.setup();
		while(true) {
			
			await delay(50);
			
			await p.roboLoop();
		}
		console.log("stopped");
	} catch (err) {
		//p.println(err);
	}
}
function runCode()
{
	var p = {};
	var applyUserCode = eval(jsCode);	
	applyUserCode(p);
	runSimulation(p)

}



