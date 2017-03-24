package tests;

import flash.geom.Point;
import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class IndexerTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    private var array:Array<Point>;
    private var openflVector:openfl.Vector<Point>;
    private var haxeVector:haxe.ds.Vector<Point>;
    private var map:Map<Int, Point>;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Indexer Test";
        description = "Square bracket operator, key lookups.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(localReference, null, "localReference", 0, 1, "Local reference, outside the loop for comparison."),
            new MethodTest(arrayIndex, null, "arrayIndex", 0, 1, "Array square bracket operator `[]`."),
            new MethodTest(openflVectorIndex, null, "openflVectorIndex", 0, 1, "OpenFL vector square bracket operator `[]`."),
            new MethodTest(haxeVectorIndex, null, "haxeVectorIndex", 0, 1, "Haxe vector square bracket operator `[]`."),
            new MethodTest(mapGetKey, null, "mapGetKey", 0, 1, "Map square bracket operator - get key.")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        array = new Array<Point>();
        openflVector = new openfl.Vector<Point>();
        haxeVector = new haxe.ds.Vector<Point>(1000);
        map = new Map<Int, Point>();

        for (i in 0 ... 1000) {
            var point:Point = new Point(i, i);
            array.push(point);
            openflVector.push(point);
            haxeVector.set(i, point);
            map.set(i, point);
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

    public function localReference():Void {
        var point:Point = array[500];
        for (i in 0 ... loops) {
            point.x = 1;
        }
    }

    public function arrayIndex():Void {
        for (i in 0 ... loops) {
            array[500].x = i;
        }
    }

    public function openflVectorIndex():Void {
        for (i in 0 ... loops) {
            openflVector[500].x = i;
        }
    }

    public function haxeVectorIndex():Void {
        for (i in 0 ... loops) {
            haxeVector[500].x = i;
        }
    }

    public function mapGetKey():Void {
        for (i in 0 ... loops) {
            map[500].x = i;
        }
    }

}

