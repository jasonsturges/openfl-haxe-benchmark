package tests;

import performance.model.MethodTest;
import performance.model.TestSuite;

class LoopHoistingTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    private var collection:Array<Int>;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Loop Hoisting";
        description = "Demonstration of loop invariant code motion / loop hoisting.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000;
        iterations = 4;
        tests = [
            new MethodTest(unhoisted, null, "For Loop Unhoisted", 0, 1, "For loop unhoisted iteration."),
            new MethodTest(hoisted, null, "For Loop Hoisted", 0, 1, "For loop hoisted iteration"),
            new MethodTest(whileUnhoised, null, "While Loop Unhoisted", 0, 1, "While loop unhoisted iteration."),
            new MethodTest(whileHoised, null, "While Loop Unhoisted", 0, 1, "While loop unhoisted iteration.")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        collection = new Array<Int>();

        for (i in 0 ... 1000) {
            collection.push(i);
        }
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


    public function unhoisted():Void {
        for (i in 0 ... loops) {
            for (j in 0 ... collection.length) {
            }
        }
    }

    public function hoisted():Void {
        var length:Int = collection.length;
        for (i in 0 ... loops) {
            for (j in 0 ... length) {
            }
        }
    }

    public function whileUnhoised():Void {
        for (i in 0 ... loops) {
            var n:Int = 0;
            while (n < collection.length) {
                n++;
            }
        }
    }

    public function whileHoised():Void {
        var length:Int = collection.length;
        for (i in 0 ... loops) {
            var n:Int = 0;
            while(n < length) {
                n++;
            }
        }
    }

}

