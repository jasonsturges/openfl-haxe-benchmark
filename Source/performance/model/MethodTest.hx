package performance.model;

import flash.Lib;

class MethodTest extends AbstractTest {

    //------------------------------
    //  model
    //------------------------------

    public var method:Dynamic;
    public var params:Array<Dynamic>;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(method:Dynamic,
                        ?params:Array<Dynamic>,
                        ?name:String,
                        iterations:UInt = 0,
                        loops:UInt = 1,
                        ?description:String) {
        super(name, iterations, loops, description);

        this.method = method;
        this.params = params != null ? params : [];
    }

    override public function run():Float {
        var t:Float = -1;

        try {
            t = Lib.getTimer();

            for (i in 0...loops) {
                Reflect.callMethod(this, method, params);
            }

            t = Lib.getTimer() - t;
        } catch (error:String) {
            trace("Test failed: " + error);
            return -1;
        }

        logIteration(t);
        return cast t;
    }

}
