package benchmark.model;

import openfl.events.Event;
import openfl.events.EventDispatcher;
import benchmark.event.TestEvent;

class AbstractTest extends EventDispatcher {

    //------------------------------
    //  model
    //------------------------------

    public var name:String;
    public var description:String;
    public var iterations:UInt;
    public var loops:UInt;
    public var average:Float;
    public var deviation:Float;
    public var max:Float;
    public var min:Float;
    public var timeLog:Array<Float>;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(?name:String, ?iterations:UInt = 0, ?loops:UInt = 1, ?description:String) {
        super();

        this.name = name;
        this.iterations = iterations;
        this.loops = loops;
        this.description = description;

        average = -1;
        max = -1;
        min = -1;
        deviation = 0;

        timeLog = [];
    }

    public function run():Float {
        return -1;
    }

    public function complete():Void {
        dispatchEvent(new TestEvent(TestEvent.COMPLETE));
    }

    private function logIteration(time:Float):Void {
        timeLog.push(time);
        if (min == -1 || time < min)
            min = time;
        if (time > max)
            max = time;
        var l:UInt = timeLog.length;

        average = average * (l - 1) / l + time / l;

        deviation = time == 0 ? 0 : (max - min) / average;
    }

}
