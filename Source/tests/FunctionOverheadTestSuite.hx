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
            new MethodTest(instanceFunctionTest, null, "Instance function"),
            new MethodTest(staticFunctionTest, null, "Static function"),
            new MethodTest(namedLocalFunctionTest, null, "Named local function"),
            //new MethodTest(function() { }, null, "Anonymous local function"),
            new MethodTest(referenceInstanceFunctionTest, null, "Instance function reference"),
            new MethodTest(referenceStaticFunctionTest, null, "Static function reference"),
            new MethodTest(referenceNamedLocalFunctionTest, null, "Named local function reference"),
            new MethodTest(referenceAnonymousFunctionTest, null, "Anonymous local function reference"),
            new MethodTest(reflectCallMethodInstanceTest, null, "Reflect `callMethod()` instance function"),
            new MethodTest(reflectCallMethodStaticTest, null, "Reflect `callMethod()` static function")
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

