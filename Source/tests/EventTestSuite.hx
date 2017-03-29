package tests;

import openfl.events.Event;
import benchmark.model.MethodTest;
import benchmark.model.TestSuite;

class EventTestSuite extends TestSuite {

    //------------------------------
    //  properties
    //------------------------------


    //------------------------------
    //  methods
    //------------------------------

    public function new() {
        super();

        name = "Event Test";
        description = "Event dispatching operations.";
        initFunction = initialize;
        baselineTest = new MethodTest(baseline);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(dispatchHandled, null, "Dispatch and handle an event"),
            new MethodTest(dispatchUnhandled, null, "Dispatch an unhandled an event")
        ];
    }

    private function eventHandler(event:Event):Void {
        //  do nothing
    }


    //------------------------------
    //  initialization
    //------------------------------

    public function initialize():Void {
        addEventListener(Event.CHANGE, eventHandler);
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

    public function dispatchHandled():Void {
        for (i in 0 ... loops) {
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    public function dispatchUnhandled():Void {
        for (i in 0 ... loops) {
            dispatchEvent(new Event(Event.CANCEL));
        }
    }

}

