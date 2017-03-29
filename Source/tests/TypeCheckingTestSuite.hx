package tests;

import openfl.display.MovieClip;
import benchmark.model.MethodTest;
import benchmark.model.TestSuite;


/**
    Type checking peformance tests.

    TODO: Consider adding the following cases:
      - `$type()` test here.
      - `Type.typeof()`
      - `Type.getClassName()`
**/
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
        loops = 100000;
        iterations = 4;
        tests = [
            new MethodTest(isTest, null, "Using `Std.Is()`"),
            new MethodTest(getClassTest, null, "Using `Type.getClass()`")
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

    public function getClassTest():Void {
        for (i in 0 ... loops) {
            if(Type.getClass(obj) == MovieClip) {
                // do nothing
            }
        }
    }

}

