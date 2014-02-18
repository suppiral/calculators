// in calc/Calculator.hx
package calc;

class Calculator 
{
	// a map data structure which will hold an function that takes 2 Floats and returns a Float
	// and its String representation
	private var actions : Map<String, Float -> Float -> Float>;// 3,4*

	// constructor
	public function new()
	{
		actions = [ "**" => Math.pow ];
	}

	// enable adding functions to our map
	public function addAction(key : String, value : Float -> Float -> Float) 
	{
		actions.set(key, value);
	}

	// gets an expressions and returns its result
	public function calculate(exp : String) : Float
	{
		var pattern : EReg = ~/\([^\(]*?\)/; /// 5*

		if (!pattern.match(exp))
			throw "invalid expression " + exp; /// 6*

		// each iteration, tries to calculate the inner most expression until non are left
		do 
		{
			var action = parseExp(pattern.matched(0)); 
			var result = calc(action.act, action.a, action.b);
			exp = pattern.replace(exp, " " + Std.string(result));
		} while(pattern.match(exp));
		return Std.parseFloat(exp); /// 7*
	}
	// parse the expression and returns a struct with three fields:
	// act - function representation
	// a   - first parameter
	// b   - second parameter
	public function parseExp(exp : String) : { act : String, a : Float, b : Float } /// 8*
	{
		// a regular expression that catches expressions of the pattern '<num> <func> <num>'
		var pattern : EReg = ~/(-?\d+\.?\d*)(\s*)(.+?)(\s*)(-?\d+\.?\d*)/;
		if (pattern.match(exp))
			return { act : pattern.matched(3), a : Std.parseFloat(pattern.matched(1)), b : Std.parseFloat(pattern.matched(5)) } /// 9*
		// else
		throw "Error while parsing: " + exp;
	}

	// takes an action representation an two Floats and returns the result of the function
	public function calc(func : String, a : Float, b : Float) : Float
	{
		try {
			return actions[func](a, b);
		} 
		catch (msg : String) { throw "no such function " + func + " in calculator"; }
	}

}