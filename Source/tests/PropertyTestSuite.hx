package tests;

import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class PropertyTestSuite extends TestSuite {

//------------------------------
//  properties
//------------------------------

    private var _property:UInt;

    public var property(get, set):UInt;

    public function get_property():UInt {
        return _property;
    }

    public function set_property(value:UInt):UInt {
        return _property = value;
    }


//------------------------------
//  methods
//------------------------------

    public function new() {
        super();

        name = "Property Test";
        description = "Property versus field access and mutation";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(fieldValue, null, "Field value"),
            new MethodTest(propertyAccessor, null, "Property Accessor"),
            new MethodTest(fieldAssignment, null, "Field Assignment"),
            new MethodTest(propertyMutator, null, "Property Mutator"),
            new MethodTest(reflectField, null, "Reflect Field"),
            new MethodTest(reflectProperty, null, "Reflect Property"),
            new MethodTest(reflectSetField, null, "Reflect Set Field"),
            new MethodTest(reflectSetProperty, null, "Reflect Set Property")
        ];
    }


//------------------------------
//  initialization
//------------------------------

    public function initialize():Void {
        _property = 0;
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

    public function fieldValue():Void {
        var n:UInt;

        for (i in 0 ... loops) {
            n = _property;
        }
    }

    public function propertyAccessor():Void {
        var n:UInt;

        for (i in 0 ... loops) {
            n = property;
        }
    }

    public function fieldAssignment():Void {
        for (i in 0 ... loops) {
            _property = i;
        }
    }

    public function propertyMutator():Void {
        for (i in 0 ... loops) {
            property = i;
        }
    }

    public function reflectField():Void {
        var n:UInt;

        for (i in 0 ... loops) {
            n = Reflect.field(this, "_property");
        }
    }

    public function reflectProperty():Void {
        var n:UInt;

        for (i in 0 ... loops) {
            n = Reflect.getProperty(this, "property");
        }
    }

    public function reflectSetField():Void {
        for (i in 0 ... loops) {
            Reflect.setField(this, "_property", i);
        }
    }

    public function reflectSetProperty():Void {
        for (i in 0 ... loops) {
            Reflect.setProperty(this, "property", i);
        }
    }

}

