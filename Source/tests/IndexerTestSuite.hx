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
            i % 1000;
        }
    }


    //------------------------------
    //  tests
    //------------------------------

    public function arrayIndex():Void {
        for (i in 0 ... loops) {
            array[i % 1000].x = i;
        }
    }

    public function openflVectorIndex():Void {
        for (i in 0 ... loops) {
            openflVector[i % 1000].x = i;
        }
    }

    public function haxeVectorIndex():Void {
        for (i in 0 ... loops) {
            haxeVector[i % 1000].x = i;
        }
    }

    public function mapGetKey():Void {
        for (i in 0 ... loops) {
            map[i % 1000].x = i;
        }
    }

}

