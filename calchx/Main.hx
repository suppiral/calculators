// in calc/Main.hx
package calc;

class Main
{
	public static function main()
	{
		// create and init calculator
		var mycalc : Calculator = new Calculator();

		mycalc.addAction("+", function(a : Float, b : Float) : Float { return a+b; }); /// 1*
		mycalc.addAction("-", function(a : Float, b : Float) : Float { return a-b; });
		mycalc.addAction("*", function(a : Float, b : Float) : Float { return a*b; });
		mycalc.addAction("/", function(a : Float, b : Float) : Float { return a/b; });

		Sys.println("===============================================================");
		Sys.println("A simple haxe calculator. each expression must be wrapped in ()");
		Sys.println("For example: ((5-3) * (2+ (1/3)))");
		Sys.println("To quit, press ^C");
		Sys.println("===============================================================");

		// read expressions and write results
		while (true)
		{
			var exp = Sys.stdin().readLine();
			try {
				var result = mycalc.calculate(exp); /// 2*
				Sys.println(result);
			}
			catch (msg : String) { trace(msg); }
		}
	}
}
