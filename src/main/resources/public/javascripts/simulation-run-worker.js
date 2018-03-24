var jsCode;
onmessage = function(e)
{
	 jsCode = e.data;
	//console.log(jsCode);
	printCode();
	
}

function printCode()
{
var userCode = eval(jsCode);
console.log(userCode);
}

