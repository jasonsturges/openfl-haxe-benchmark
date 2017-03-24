package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class BitwiseTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Bitwise Test";
        description = "Bitwise operations on `Int` data type.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000000;
        iterations = 4;
        tests = [
            new MethodTest(not, null, "Bitwise Not", 0, 1, "`~` operator, negation."),
            new MethodTest(and, null, "Bitwise And", 0, 1, "`&` operator, round to even number."),
            new MethodTest(or, null, "Bitwise Or", 0, 1, "`|` operator, floor."),
            new MethodTest(xor, null, "Bitwise Xor", 0, 1, "`^` operator, zero variable"),
            new MethodTest(shiftLeft, null, "Shift Left", 0, 1, "`<<` operator, multiply by 2."),
            new MethodTest(shiftRight, null, "Shift Right", 0, 1, "`>>` operator, divide by 2."),
            new MethodTest(unsignedShiftRight, null, "Unsigned Shift Right", 0, 1, "`>>>` operator, rounded mean")
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
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i;
        }
    }


    //------------------------------
    //  tests
    //------------------------------

    public function not():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = ~i;
        }
    }

    public function and():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i & 0xfffe;
        }
    }

    public function or():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i | 0;
        }
    }

    public function xor():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i ^ i;
        }
    }

    public function shiftLeft():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i << 1;
        }
    }

    public function shiftRight():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i >> 1;
        }
    }

    public function unsignedShiftRight():Void {
        var n:Int = 0;
        for (i in 0 ... loops) {
            n = i >>> 1;
        }
    }

}
