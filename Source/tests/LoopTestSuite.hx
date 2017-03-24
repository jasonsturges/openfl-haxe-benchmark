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
            new MethodTest(forIncrement, null, "For Increment", 0, 1, "For loop incremental iteration."),
            new MethodTest(whileIncrement, null, "While Increment", 0, 1, "While loop incremental iteration."),
            new MethodTest(whileDecrement, null, "While Decrement", 0, 1, "While loop decremental iteration."),
            new MethodTest(doWhileIncrement, null, "Do While Increment", 0, 1, "Do while loop incremental iteration."),
            new MethodTest(doWhileDecrement, null, "Do While Decrement", 0, 1, "Do while loop decremental iteration.")
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

