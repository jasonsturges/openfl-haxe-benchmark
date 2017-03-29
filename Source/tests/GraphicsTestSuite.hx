package tests;

import flash.Vector;
import openfl.display.Graphics;
import openfl.display.Shape;
import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class GraphicsTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    var shape:Shape;

    var commands:Vector<Int>;
    var data:Vector<Float>;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Graphics Test";
        description = "Drawing operations using `Graphics` object.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 100000;
        iterations = 4;
        tests = [
            new MethodTest(lineTo, null, "Draw line calling `shape.graphics.lineTo`"),
            new MethodTest(lineToReference, null, "Draw line using local graphics reference"),
            new MethodTest(drawPath, null, "Draw path using single `drawPath` call with precomputed commands")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        shape = new Shape();

        commands = new Vector<Int>();
        data = new Vector<Float>();
        for (i in 0 ... loops) {
            commands.push(2);
            data.push(20.0);
            data.push(20.0);
        }
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
            shape.graphics.lineTo(20.0, 20.0);
        }
    }

    public function lineToReference():Void {
        shape.graphics.clear();
        var g:Graphics = shape.graphics;
        for (i in 0 ... loops) {
            g.lineTo(20.0, 20.0);
        }
    }

    public function drawPath():Void {
        shape.graphics.clear();
        shape.graphics.drawPath(commands, data);
    }

}

