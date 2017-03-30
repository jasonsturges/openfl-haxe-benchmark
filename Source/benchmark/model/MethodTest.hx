package benchmark.model;

import openfl.Lib;

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
                        ?name:String) {
        super(name);

        this.method = method;
        this.params = params != null ? params : [];
    }

    override public function run():Int {
        var t:Int = -1;

        try {
            t = Lib.getTimer();
            Reflect.callMethod(this, method, params);
            t = Lib.getTimer() - t;
        } catch (error:String) {
            trace("Test failed: " + error);
            return -1;
        }

        logIteration(t);
        return cast t;
    }

}
