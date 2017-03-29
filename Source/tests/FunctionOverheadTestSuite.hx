package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class FunctionOverheadTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Function Overhead Test";
        description = "Function overhead from different scopes";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000000;
        iterations = 4;
        tests = [
            new MethodTest(instanceFunctionTest, null, "Instance Function", 0, 1, "Call function from instance."),
            new MethodTest(staticFunctionTest, null, "Static Function", 0, 1, "Call static function."),
            new MethodTest(namedLocalFunctionTest, null, "Named Local Function", 0, 1, "Call named local function from inside block expression."),
            //new MethodTest(function() { }, null, "Anonymous Local Function", 0, 1, "Call anonymous local function."),
            new MethodTest(referenceInstanceFunctionTest, null, "Instance Function Reference", 0, 1, "Call function from instance using a reference."),
            new MethodTest(referenceStaticFunctionTest, null, "Static Function Reference", 0, 1, "Call static function function using a reference."),
            new MethodTest(referenceNamedLocalFunctionTest, null, "Named Local Function Reference", 0, 1, "Call local function from inside block expression using a reference."),
            new MethodTest(referenceAnonymousFunctionTest, null, "Anonymous Local Function Reference", 0, 1, "Call local function from inside block expression using a reference."),
            new MethodTest(reflectCallMethodInstanceTest, null, "Reflect callMethod Instance Function", 0, 1, "Call function from instance using reflection call method."),
            new MethodTest(reflectCallMethodStaticTest, null, "Reflect callMethod Static Function", 0, 1, "Call static function using reflection call method.")
        ];
    }


    private function instanceFunction():Void {
    }

    private static function staticFunction():Void {
    }



    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
    }


    //------------------------------
    //  baseline
    //------------------------------

    public function baseline():Void {
        for (i in 0 ... loops) {
        }
    }


    //------------------------------
    //  tests
    //------------------------------

    public function instanceFunctionTest():Void {
        for (i in 0 ... loops) {
            instanceFunction();
        }
    }

    public function staticFunctionTest():Void {
        for (i in 0 ... loops) {
            FunctionOverheadTestSuite.staticFunction();
        }
    }

    public function namedLocalFunctionTest():Void {
        function localFunction() { }

        for (i in 0 ... loops) {
            localFunction();
        }
    }

    public function referenceInstanceFunctionTest():Void {
        var fn:Dynamic = instanceFunction;
        
        for (i in 0 ... loops) {
            fn();
        }
    }

    public function referenceStaticFunctionTest():Void {
        var fn:Dynamic = FunctionOverheadTestSuite.staticFunction;

        for (i in 0 ... loops) {
            fn();
        }
    }

    public function referenceNamedLocalFunctionTest():Void {
        var fn:Dynamic = function localFunction() { }

        for (i in 0 ... loops) {
            fn();
        }
    }

    public function referenceAnonymousFunctionTest():Void {
        var fn:Dynamic = function() { };

        for (i in 0 ... loops) {
            fn();
        }
    }

    public function reflectCallMethodInstanceTest():Void {
        for (i in 0 ... loops) {
            Reflect.callMethod(this, instanceFunction, []);
        }
    }

    public function reflectCallMethodStaticTest():Void {
        for (i in 0 ... loops) {
            Reflect.callMethod(this, FunctionOverheadTestSuite.staticFunction, []);
        }
    }

}

