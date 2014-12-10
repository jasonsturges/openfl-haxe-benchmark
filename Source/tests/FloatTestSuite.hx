package tests;

import performance.model.MethodTest;
import performance.model.TestSuite;

class FloatTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Math Test";
        description = "Mathematical operations";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000000;
        iterations = 4;
        tests = [
            new MethodTest(addition, null, "addition", 0, 1, "addition"),
            new MethodTest(subtraction, null, "subtraction", 0, 1, "subtraction"),
            new MethodTest(division, null, "division", 0, 1, "division"),
            new MethodTest(multiplication, null, "multiplication", 0, 1, "multiplication")
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

    public function addition():Void {
        for (i in 0 ... loops) {
            var n:Float = i + 0.1;
        }
    }

    public function subtraction():Void {
        for (i in 0 ... loops) {
            var n:Float = i - 0.1;
        }
    }

    public function division():Void {
        for (i in 0 ... loops) {
            var n:Float = i / 1000;
        }
    }

    public function multiplication():Void {
        for (i in 0 ... loops) {
            var n:Float = i * 0.001;
        }
    }

}

