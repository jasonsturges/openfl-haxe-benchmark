package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class MapTestSuite extends TestSuite {

//------------------------------
//  properties
//------------------------------

    public var map:Map<String, Dynamic>;
    public var obj:Dynamic;


//------------------------------
//  methods
//------------------------------

    public function new() {
        super();

        name = "Map Test";
        description = "Map and object key value access.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(mapGet, null, "Map using `get()`"),
            new MethodTest(mapBracket, null, "Map using square brackets operator"),
            new MethodTest(objectDotNotation, null, "Object using dot notation"),
            new MethodTest(objectReflect, null, "Object using reflection")
        ];
    }


//------------------------------
//  initialization
//------------------------------

    public function initialize():Void {
        map = new Map<String, Dynamic>();
        map["prop1"] = "abc";
        map["prop2"] = 123;

        obj = { prop1: "abc", prop2: 123 };
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

    public function mapGet():Void {
        for (i in 0 ... loops) {
            map.get("prop1");
        }
    }

    public function mapBracket():Void {
        for (i in 0 ... loops) {
            map["prop1"];
        }
    }

    public function objectDotNotation():Void {
        for (i in 0 ... loops) {
            obj.prop1;
        }
    }

    public function objectReflect():Void {
        for (i in 0 ... loops) {
            Reflect.field(obj, "prop1");
        }
    }

}

