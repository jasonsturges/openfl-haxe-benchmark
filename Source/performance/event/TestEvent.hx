package performance.event;

import openfl.events.Event;
import performance.model.AbstractTest;
import performance.model.TestSuite;

class TestEvent extends Event {

    //------------------------------
    //  singleton instance
    //------------------------------

    public static var START:String = "start";
    public static var COMPLETE:String = "complete";


    //------------------------------
    //  model
    //------------------------------

    public var test:AbstractTest;
    public var testSuite:TestSuite;


    //------------------------------
    //  singleton instance
    //------------------------------

    public function new(type:String, ?test, ?testSuite, bubbles:Bool = false, cancelable:Bool = false):Void {
        super(type, bubbles, cancelable);

        this.test = test;
        this.testSuite = testSuite;
    }

}
