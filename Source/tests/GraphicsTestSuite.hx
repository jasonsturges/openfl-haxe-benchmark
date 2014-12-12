package tests;

import openfl.display.Graphics;
import openfl.display.Shape;
import performance.model.MethodTest;
import performance.model.TestSuite;

class GraphicsTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    var shape:Shape;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Graphics Test";
        description = "Drawing operations using `Graphics` object.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(lineTo, null, "Draw Line", 0, 1, "Draw lineTo calling `shape.graphics.lineTo`."),
            new MethodTest(lineToReference, null, "Draw Line with Reference", 0, 1, "Draw lintTo using local graphics reference."),
            new MethodTest(drawPath, null, "Draw Path", 0, 1, "Draw line using `drawPath`."),
            new MethodTest(drawPathSingle, null, "Draw Path", 0, 1, "Draw line using single `drawPath` call with precomputed commands and data.")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        shape = new Shape();
    }


    //------------------------------
    //  baseline
    //------------------------------

    public function baseline():Void {
        shape.graphics.clear();
        for (i in 0 ... loops) {
        }
    }


    //------------------------------
    //  tests
    //------------------------------

    public function lineTo():Void {
        shape.graphics.clear();
        for (i in 0 ... loops) {
            shape.graphics.lineTo(i % 100 * 3, i % 200);
        }
    }

    public function lineToReference():Void {
        shape.graphics.clear();
        var g:Graphics = shape.graphics;
        for (i in 0 ... loops) {
            g.lineTo(i % 100 * 3, i % 200);
        }
    }

    public function drawPath():Void {
        shape.graphics.clear();
        for (i in 0 ... loops) {
            // TODO: Resolve Flash error: Array<Int> should be flash.Vector<Int>
            #if (!flash && !js)
            shape.graphics.drawPath([2], [(i % 100 * 3), (i % 200)]);
            #end
        }
    }

    public function drawPathSingle():Void {
        shape.graphics.clear();
        var commands:Array<Int> = [];
        var data:Array<Float> = [];
        for (i in 0 ... loops) {
            commands.push(2);
            data.push(i % 100 * 3);
            data.push(i % 200);
        }
        // TODO: Resolve Flash error: Array<Int> should be flash.Vector<Int>
        #if (!flash && !js)
        shape.graphics.drawPath(commands, data);
        #end
    }

}

