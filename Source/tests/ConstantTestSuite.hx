package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class ConstantTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    public static inline var INLINE_CONSTANT:Int = 1;
    public var READONLY_CONSTANT(default, never):Int = 1;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Constants";
        description = "Approaches to constant values in Haxe";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(inlineConstant, null, "Inline constant", 0, 1, "Get static constant value as inline var"),
            new MethodTest(readonlyConstant, null, "Readonly constant", 0, 1, "Get constant value as readonly var"),
        ];
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
        var n;

        for (i in 0 ... loops) {
            n = 1 + i;
        }
    }


    //------------------------------
    //  tests
    //------------------------------

    public function inlineConstant():Void {
        var n;

        for (i in 0 ... loops) {
            n = INLINE_CONSTANT + i;
        }
    }

    public function readonlyConstant():Void {
        var n;

        for (i in 0 ... loops) {
            n = READONLY_CONSTANT + i;
        }
    }

}