package tests;

import performance.model.MethodTest;
import performance.model.TestSuite;

class FunctionScopeTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Function Scope Test";
        description = "Function overhead from different scopes.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000000;
        iterations = 4;
        tests = [
            new MethodTest(instanceFunctionTest, null, "Instance Function", 0, 1, "Call function from instance."),
            new MethodTest(staticFunctionTest, null, "Static Function", 0, 1, "Call static function."),
            new MethodTest(referenceInstanceFunctionTest, null, "Instance Function Reference", 0, 1, "Call function from instance using a reference."),
            new MethodTest(referenceStaticFunctionTest, null, "Static Function Reference", 0, 1, "Call static function function using a reference."),
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
            FunctionScopeTestSuite.staticFunction();
        }
    }

    public function referenceInstanceFunctionTest():Void {
        var fn:Dynamic = instanceFunction;
        for (i in 0 ... loops) {
            fn();
        }
    }

    public function referenceStaticFunctionTest():Void {
        var fn:Dynamic = FunctionScopeTestSuite.staticFunction;
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
            Reflect.callMethod(this, FunctionScopeTestSuite.staticFunction, []);
        }
    }

}

