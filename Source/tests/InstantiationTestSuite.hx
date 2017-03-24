package tests;

import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.MovieClip;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Matrix3D;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class InstantiationTestSuite extends TestSuite {


    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Instantiation Test";
        description = "Instantiation times.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(newPoint, null, "newPoint", 0, 1, "Instantiate a new Point."),
            new MethodTest(newRectangle, null, "newRectangle", 0, 1, "Instantiate a new Rectangle."),
            new MethodTest(newMatrix, null, "newMatrix", 0, 1, "Instantiate a new Matrix."),
            new MethodTest(newMatrix3D, null, "newMatrix3D", 0, 1, "Instantiate a new Matrix3D."),
            new MethodTest(newShape, null, "newShape", 0, 1, "Instantiate a new Shape."),
            new MethodTest(newSprite, null, "newSprite", 0, 1, "Instantiate a new Sprite."),
            new MethodTest(newMovieClip, null, "newMovieClip", 0, 1, "Instantiate a new MovieClip."),
            new MethodTest(newBitmap, null, "newBitmap", 0, 1, "Instantiate a new Bitmap."),
            new MethodTest(newBitmapData, null, "newBitmapData", 0, 1, "Instantiate a new 64x64 BitmapData.")
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

    public function newPoint():Void {
        for (i in 0 ... loops) {
            new Point();
        }
    }

    public function newRectangle():Void {
        for (i in 0 ... loops) {
            new Rectangle();
        }
    }

    public function newMatrix():Void {
        for (i in 0 ... loops) {
            new Matrix();
        }
    }

    public function newMatrix3D():Void {
        for (i in 0 ... loops) {
            new Matrix3D();
        }
    }

    public function newShape():Void {
        for (i in 0 ... loops) {
            new Shape();
        }
    }

    public function newSprite():Void {
        for (i in 0 ... loops) {
            new Sprite();
        }
    }

    public function newMovieClip():Void {
        for (i in 0 ... loops) {
            new MovieClip();
        }
    }

    public function newBitmap():Void {
        for (i in 0 ... loops) {
            new Bitmap();
        }
    }

    public function newBitmapData():Void {
        for (i in 0 ... loops) {
            new BitmapData(64, 64);
        }
    }

}
