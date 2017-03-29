package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

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
            new MethodTest(unhoisted, null, "For loop unhoisted"),
            new MethodTest(hoisted, null, "For loop hoisted"),
            new MethodTest(whileUnhoisted, null, "While loop unhoisted"),
            new MethodTest(whileHoisted, null, "While loop unhoisted")
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

    public function whileUnhoisted():Void {
        for (i in 0 ... loops) {
            var n:Int = 0;
            while (n < collection.length) {
                n++;
            }
        }
    }

    public function whileHoisted():Void {
        var length:Int = collection.length;
        for (i in 0 ... loops) {
            var n:Int = 0;
            while(n < length) {
                n++;
            }
        }
    }

}

