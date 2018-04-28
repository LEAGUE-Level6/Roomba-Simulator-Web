var jsCode;
var first = true;
var bumpLeft = undefined;
var bumpRight = undefined;
onmessage = function(e)
{
	if(first)
		{
		jsCode = e.data;
		printCode();
		runCode();
		first = false;
		}
	
	switch(e.data.method){
	case "isBumpRight":
		bumpRight = e.data.isBump;
		
		break;
	
	case "isBumpLeft":
		bumpLeft = e.data.isBump;
		break;
	default: 
		console.log("Unknown Method: " + e.data.method);
	}
	// console.log(jsCode);
	
	
	
	
}

function printCode()
{

var userCode = eval(jsCode);

console.log(userCode);
// setTimeout(printCode, 5000);

}

function driveDirect(left, right)
{
	postMessage({"method": "driveDirect", "left": left, "right": right});
}

function println(message)
{
postMessage({"method":"println", "message":message});
}

function delay(millis){
	return new Promise(resolve => setTimeout(resolve, millis));
}

async function isBumpRight()
{
	 bumpRight = undefined;
  postMessage({"method":"isBumpRight"})	
  
if(await checkReadyBump(true))
{
 console.log(bumpRight);
}
 return bumpRight;
 
}
 
async function isBumpLeft()
{
	 bumpLeft = undefined;
	  postMessage({"method":"isBumpLeft"})	
	  
	if(await checkReadyBump(false))
	{
	 console.log(bumpLeft);
	}
	 return bumpLeft;
	 
}

 async function checkReadyBump(b)
{	
	 var bump;
	await delay(10);
	if(b  = true){
	 bump = bumpRight;
	}
	else if(b == false)
		{
		bump = bumpLeft;
		}
		
	
if(typeof(bump)==="undefined")
	{
	//delay(100);
	checkReadyBump(b);
	
	}
else if(typeof(bump)!=="undefined")
	{
	return true;
	}

}
 

async function runSimulation(p){
	// var t = myTurn;
	
	try {
		await p.setup();
		while(true) {
			
			await delay(50);
			
			await p.roboLoop();
		}
		console.log("stopped");
	} catch (err) {
		// p.println(err);
	}
}
function runCode()
{
	var p = {};
	var applyUserCode = eval(jsCode);	
	p.println = println;
	// println = println.bind(p);
	

	
	applyUserCode(p);
	runSimulation(p)
	

}



