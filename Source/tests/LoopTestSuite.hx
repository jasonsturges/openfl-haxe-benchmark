package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class LoopTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Loop Test";
        description = "Looping over collections.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000;
        iterations = 4;
        tests = [
            new MethodTest(forIncrement, null, "For increment"),
            new MethodTest(whileIncrement, null, "While increment"),
            new MethodTest(whileDecrement, null, "While decrement"),
            new MethodTest(doWhileIncrement, null, "Do while increment"),
            new MethodTest(doWhileDecrement, null, "Do while decrement")
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
        for (i in 0 ... loops) {
        }
    }


    //------------------------------
    //  tests
    //------------------------------

    public function forIncrement():Void {
        for (i in 0 ... loops) {
            for (i in 0 ... 1000) {
                // do nothing
            }
        }
    }

    public function whileIncrement():Void {
        for (i in 0 ... loops) {
            var i:UInt = 0;
            while (i < 1000) {
                i++;
            }
        }
    }

    public function whileDecrement():Void {
        for (i in 0 ... loops) {
            var i:UInt = 1000;
            while (i > 0) {
                i--;
            }
        }
    }

    public function doWhileIncrement():Void {
        for (i in 0 ... loops) {
            var i:UInt = 0;
            do {
                i++;
            } while (i < 1000);
        }
    }

    public function doWhileDecrement():Void {
        for (i in 0 ... loops) {
            var i:UInt = 1000;
            do {
                i--;
            } while (i > 0);
        }
    }

}

