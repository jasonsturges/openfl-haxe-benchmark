package tests;

import flash.geom.Point;
import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class KeyExistsTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    private var map:Map<Int, Int>;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Key Exists Test";
        description = "Lookup operations to verify a key exists";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 10000;
        iterations = 4;
        tests = [
            new MethodTest(exists, null, "exists", 0, 1, "Use `exists()` function to verify key."),
            new MethodTest(squareBracket, null, "squareBracket", 0, 1, "Use square bracket operator `[]` and test for null to verify key."),
            new MethodTest(lambaHas, null, "lambaHas", 0, 1, "Use `Lamba.has()` to verify key.")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        map = new Map<Int, Int>();

        for (i in 0 ... loops) {
            map.set(i, i);
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

    public function exists():Void {
        for (i in 0 ... loops) {
            map.exists(i);
        }
    }

    public function squareBracket():Void {
        for (i in 0 ... loops) {
            map[i] != null;
        }
    }

    public function lambaHas():Void {
        for (i in 0 ... loops) {
            Lambda.has(map, i);
        }
    }

}

