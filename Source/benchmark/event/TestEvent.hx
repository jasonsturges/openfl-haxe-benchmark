package benchmark.event;

import openfl.events.Event;
import benchmark.model.AbstractTest;
import benchmark.model.TestSuite;

class TestEvent extends Event {

    //------------------------------
    //  constants
    //------------------------------

    public static var START:String = "start";
    public static var COMPLETE:String = "complete";


    //------------------------------
    //  model
    //------------------------------

    public var test:AbstractTest;
    public var testSuite:TestSuite;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(type:String, ?test, ?testSuite, bubbles:Bool = false, cancelable:Bool = false):Void {
        super(type, bubbles, cancelable);

        this.test = test;
        this.testSuite = testSuite;
    }

}
