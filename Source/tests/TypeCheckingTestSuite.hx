package tests;

import openfl.display.MovieClip;
import performance.model.MethodTest;
import performance.model.TestSuite;

class TypeCheckingTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    private var obj:MovieClip;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Type Check";
        description = "Test for type at runtime.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000000;
        iterations = 4;
        tests = [
            new MethodTest(isTest, null, "Is", 0, 1, "`Std.is` test.")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        obj = new MovieClip();
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

    public function isTest():Void {
        for (i in 0 ... loops) {
            if (Std.is(obj, MovieClip)) {
                // do nothing
            }
        }
    }

}

