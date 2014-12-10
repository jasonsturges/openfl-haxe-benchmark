package tests;

import openfl.events.Event;
import performance.model.MethodTest;
import performance.model.TestSuite;

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
        tareTest = new MethodTest(tare);
        loops = 1000000;
        iterations = 4;
        tests = [
            new MethodTest(dispatchHandled, null, "dispatchHandled", 0, 1, "Dispatch and handle an event."),
            new MethodTest(dispatchUnhandled, null, "dispatchUnhandled", 0, 1, "Dispatch an unhandle an event.")
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
    //  tare
    //------------------------------

    public function tare():Void {
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

