package performance.model;

import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.Lib;

class RenderTest extends AbstractTest {

    //------------------------------
    //  model
    //------------------------------

    public var displayObject:DisplayObject;
    public var bounds:Rectangle;
    private var bitmapData:BitmapData;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(displayObject:DisplayObject,
                        ?bounds:Rectangle,
                        ?name:String,
                        iterations:UInt = 0,
                        loops:UInt = 1,
                        ?description:String) {
        super(name, iterations, loops, description);

        this.displayObject = displayObject;
        this.bounds = bounds;
    }

    override public function run():Float {
        var rect:Rectangle = bounds != null ? bounds : displayObject.getBounds(displayObject);
        if (bitmapData == null || bitmapData.width != Math.ceil(rect.width) || bitmapData.height != Math.ceil(rect.height)) {
            try {
                bitmapData = new BitmapData(Math.ceil(rect.width), Math.ceil(rect.height), true, 0);
            } catch (error:String) {
                trace("Failed to create BitmapData: " + error);
                return -1;
            }
        }

        var matrix:Matrix = new Matrix(1, 0, 0, 1, -rect.x, -rect.y);
        bitmapData.fillRect(bitmapData.rect, 0);

        var t:Float = Lib.getTimer();
        for (i in 0 ... loops) {
            displayObject.alpha = 0.1;
            displayObject.alpha = 1;
            bitmapData.draw(displayObject, matrix);
        }
        t = Lib.getTimer() - t;

        logIteration(t);
        return cast t;
    }

}
