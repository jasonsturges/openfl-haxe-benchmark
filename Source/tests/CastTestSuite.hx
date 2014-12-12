package tests;

import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import performance.model.MethodTest;
import performance.model.TestSuite;

class CastTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------

    private var movieClip:MovieClip;
    private var displayObject:DisplayObject;


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Cast Test";
        description = "Safe and unsafe casting.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(safeDowncast, null, "safeDowncast", 0, 1, "Safely downcast a MovieClip to a DisplayObject."),
            new MethodTest(unsafeDowncast, null, "unsafeDowncast", 0, 1, "Downcast a MovieClip to a DisplayObject."),
            new MethodTest(safeUpcast, null, "safeUpcast", 0, 1, "Safely upcast a DisplayObject to a MovieClip."),
            new MethodTest(unsafeUpcast, null, "unsafeUpcast", 0, 1, "Upcast a DisplayObject to a MovieCip.")
        ];
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        movieClip = new MovieClip();
        displayObject = cast(movieClip, DisplayObject);
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

    public function safeDowncast():Void {
        for (i in 0 ... loops) {
            var obj:DisplayObject = cast(movieClip, DisplayObject);
        }
    }

    public function unsafeDowncast():Void {
        for (i in 0 ... loops) {
            var obj:DisplayObject = cast movieClip;
        }
    }

    public function safeUpcast():Void {
        for (i in 0 ... loops) {
            var obj:MovieClip = cast(displayObject, MovieClip);
        }
    }

    public function unsafeUpcast():Void {
        for (i in 0 ... loops) {
            var obj:MovieClip = cast displayObject;
        }
    }

}

