package tests;

import openfl.events.Event;
import performance.model.MethodTest;
import performance.model.TestSuite;

class FunctionInliningTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Function Inlining Test";
        description = "Inlining functions using the `inline` keyword.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000000;
        iterations = 4;
        tests = [
            new MethodTest(callMethod, null, "Call Method", 0, 1, "Call a method."),
            new MethodTest(callMethodInline, null, "Call Method Inline", 0, 1, "Inline a method.")
        ];
    }

    public function testFunction():Void {
        // do nothing
    }

    inline public function testInlineFunction():Void {
        // do nothing
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

    public function callMethod():Void {
        for (i in 0 ... loops) {
            testFunction();
        }
    }

    public function callMethodInline():Void {
        for (i in 0 ... loops) {
            testInlineFunction();
        }
    }

}

