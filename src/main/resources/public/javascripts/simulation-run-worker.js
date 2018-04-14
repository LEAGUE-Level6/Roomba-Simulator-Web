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
//setTimeout(printCode, 5000);

}
function driveDirect(left, right)
{
	postMessage({"method": "driveDirect", "left": left, "right": right});
	console.log("driveDirect");
}
function println(message)
{
	console.log("cool beans");
postMessage({"method":"println", "message":message});
}
function delay(millis){
	return new Promise(resolve => setTimeout(resolve, millis));
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
	p.println = println;
	//println = println.bind(p);
	

	
	applyUserCode(p);
	runSimulation(p)
	

}



