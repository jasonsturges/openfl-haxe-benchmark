package performance.controller;

import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import performance.event.TestEvent;
import performance.model.AbstractTest;
import performance.model.TestSuite;

class PerformanceTest extends EventDispatcher {

    //------------------------------
    //  singleton instance
    //------------------------------

    private static var instance:PerformanceTest;

    public static function getInstance():PerformanceTest {
        if (PerformanceTest.instance == null)
            PerformanceTest.instance = new PerformanceTest();

        return instance;
    }


    //------------------------------
    //  model
    //------------------------------

    private var queue:Array<TestSuite>;
    private var index:Int;
    private var iteration:UInt;
    private var synchronous:Bool;
    private var timer:Timer;
    private var currentTest:AbstractTest;
    private var currentTestSuite:TestSuite;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        queue = [];
        synchronous = false;
        index = iteration = 0;

        timer = new Timer(50, 1);
        timer.addEventListener(TimerEvent.TIMER, timerHandler);

    }

    public function enqueueTestSuite(testSuite:TestSuite):Void {
        queue.push(testSuite);
    }

    private function timerHandler(event:TimerEvent):Void {
        next();
    }

    public function runSynchronous():Void {
        synchronous = true;
        next();
    }

    public function runAsynchronous():Void {
        synchronous = false;
        next();
    }

    private function next():Void {
        if (currentTestSuite == null) {
            currentTestSuite = queue.shift();
            index = iteration = 0;

            trace("TestSuite: " + currentTestSuite.name + " (" + currentTestSuite.description + ")");

            if (currentTestSuite.initFunction != null)
                Reflect.callMethod(currentTestSuite, currentTestSuite.initFunction, []);

            if (currentTestSuite.tareTest != null) {
                runTareTest();
                trace("   Tare time: " + currentTestSuite.tareTime);
            }
        }

        if (index < currentTestSuite.tests.length) {
            if (runTest(currentTestSuite.tests[index])) {
                index++;
            }
        }

        if (index >= currentTestSuite.tests.length) {
            currentTestSuite.complete();
            currentTestSuite = null;
        }

        if (synchronous) {
            next();
        } else if (queue.length > 0 || currentTestSuite != null) {
            timer.reset();
            timer.start();
        }
    }

    private function runTareTest():Void {
        var tareTest:AbstractTest = currentTestSuite.tareTest;
        var i:Int = tareTest.iterations == 0 ? 10 : tareTest.iterations;
        var count:UInt = 0;
        var good:Bool = false;
        var t:Float = -1;
        var oldTime:Float = -1;

        while (!good && i-- > 0) {
            count++;
            t = tareTest.run();
            if (t < 0)
                continue;
            var d:Float = Math.abs(t - oldTime);
            good = (oldTime >= 0) && (d / (oldTime + t) * 2 < 0.1 || d < 2);
            oldTime = t;
        }
        tareTest.iterations = count;
        currentTestSuite.tareTime = (t < 0 || oldTime < 0) ? -1 : (t + oldTime) / 2;
    }

    private function runTest(test:AbstractTest):Bool {
        if (currentTest != test) {
            iteration = 0;
            currentTest = test;

            trace("   Test: " + currentTest.name + " (" + currentTest.description + ")");

            if (test.iterations == 0 && currentTestSuite != null)
                test.iterations = currentTestSuite.iterations;
            if (test.iterations == 0)
                test.iterations = 1;
        }
        iteration++;

        var t:Float = test.run();
        traceTestIteration(t, test);

        var completed:Bool = (t < 0 || iteration >= currentTest.iterations);
        if (completed) {
            traceTestResult(currentTest, currentTestSuite);
            dispatchEvent(new TestEvent(TestEvent.COMPLETE));

            currentTest.complete();
            currentTest = null;
        }

        return completed;
    }

    public function traceTestIteration(time:Float, test:AbstractTest):Void {
        trace("      time: " + time +
        ", min: " + test.min +
        ", max: " + test.max +
        ", average: " + test.average +
        ", deviation: " + test.deviation);
    }

    public function traceTestResult(test:AbstractTest, testSuite:TestSuite):Void {
        trace("      Result: " + ((test.average - testSuite.tareTime) / testSuite.loops) + "ms per operation");
    }

}
