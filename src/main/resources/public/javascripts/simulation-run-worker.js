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
		console.log(bumpRight);
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
  postMessage({"method":"isBumpRight"})	
  
if(checkReadyBump(bumpRight))
{
 var bump = bumpRight;
 bumpRight = undefined;
 console.log(bump);
}
 return bump;
 
}
 
async function isBumpLeft()
{
await postMessage({"method":"isBumpLeft"})
var bump = bumpLeft;
bumpLeft = false;
return bump;
}

 function checkReadyBump(b)
{
if(typeof(b)==="undefined")
	{
	checkReadyBump(b);
	}
else if(typeof(b)!=="undefined")
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



