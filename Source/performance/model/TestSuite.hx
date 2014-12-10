package performance.model;

import performance.event.TestEvent;
import Lambda;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class TestSuite extends EventDispatcher {

    //------------------------------
    //  model
    //------------------------------

    public var tests:Array<AbstractTest>;
    public var name:String;
    public var description:String;
    public var tareTest:AbstractTest;
    public var initFunction:Dynamic;
    public var tareTime:Float;
    public var initTime:Float;
    public var iterations:UInt;
    public var loops:UInt;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(?tests:Array<AbstractTest>,
                        ?name:String,
                        ?tareTest:AbstractTest,
                        ?initFunction:Dynamic,
                        iterations:UInt = 0,
                        ?description:String) {
        super();

        this.tests = tests != null ? tests : [];
        this.name = name;
        this.description = description;
        this.tareTest = tareTest;
        this.initFunction = initFunction;
        this.iterations = iterations;
    }

    public function get_time():Float {
        var time:Float = 0;
        var l:UInt = Lambda.count(tests);
        for (i in 0...l) {
            var t:Float = tests[i].average;
            if (t == -1) { return -1; }
            time += t;
        }
        return time;
    }

    public function complete():Void {
        dispatchEvent(new TestEvent(TestEvent.COMPLETE));
    }

}
