package benchmark.core;

import openfl.events.EventDispatcher;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import benchmark.constant.TestState;
import benchmark.event.TestEvent;
import benchmark.model.AbstractTest;
import benchmark.model.TestSuite;

class Benchmark extends EventDispatcher {

    //------------------------------
    //  singleton instance
    //------------------------------

    private static var instance:Benchmark;

    public static function getInstance():Benchmark {
        if (Benchmark.instance == null)
            Benchmark.instance = new Benchmark();

        return instance;
    }


    //------------------------------
    //  model
    //------------------------------

    private var queue:Array<TestSuite>;
    private var index:Int;
    private var iteration:UInt;
    private var synchronous:Bool;
    private var currentTest:AbstractTest;
    private var currentTestSuite:TestSuite;
    private var timer:Timer;
    private var state:String;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        queue = [];
        synchronous = false;
        index = iteration = 0;
        state = TestState.IDLE;

        timer = new Timer(50, 1);
        timer.addEventListener(TimerEvent.TIMER, timerHandler);

    }

    public function enqueueTestSuite(testSuite:TestSuite):Void {
        queue.push(testSuite);
    }

    public function enqueueTestSuites(testSuites:Array<TestSuite>) {
        for (t in testSuites) {
            enqueueTestSuite(t);
        }
    }

    public function runSynchronous():Void {
        synchronous = true;
        next();
    }

    public function runAsynchronous():Void {
        synchronous = false;
        next();
    }

    private function timerHandler(event:TimerEvent):Void {
        next();
    }

    private function next():Void {
        switch (state) {
            case TestState.IDLE:
                // If there are more tests to run, load next test suite
                if (queue.length > 0) {
                    currentTestSuite = queue.shift();
                    state = TestState.PENDING;
                }
            case TestState.PENDING:
                // There is a test suite to run
                trace("TestSuite: " + currentTestSuite.name + " (" + currentTestSuite.description + ")");
                state = TestState.INITIALIZE;
            case TestState.INITIALIZE:
                // Initialize the test suite
                index = iteration = 0;
                if (currentTestSuite.initFunction != null)
                    Reflect.callMethod(currentTestSuite, currentTestSuite.initFunction, []);
                state = TestState.BENCHMARK;
            case TestState.BENCHMARK:
                // Benchmark the test suite
                if (currentTestSuite.baselineTest != null) {
                    runBaselineTest();
                    trace("   Baseline time: " + currentTestSuite.baselineTime);
                }
                state = TestState.RUNNING;
            case TestState.RUNNING:
                // Run each iteration of the test suite
                if (index < currentTestSuite.tests.length) {
                    if (runTest(currentTestSuite.tests[index])) {
                        index++;
                    }
                }

                if (index >= currentTestSuite.tests.length) {
                    currentTestSuite.complete();
                    state = TestState.DISPOSE;
                }
            case TestState.DISPOSE:
                // Cleanup and dispose test suite
                currentTestSuite.dispose();
                currentTestSuite = null;
                state = TestState.IDLE;
        }

        if (synchronous) {
            next();
        } else if (queue.length > 0 || currentTestSuite != null) {
            timer.reset();
            timer.start();
        }
    }


    private function runBaselineTest():Void {
        var baselineTest:AbstractTest = currentTestSuite.baselineTest;
        var i:Int = baselineTest.iterations == 0 ? 10 : baselineTest.iterations;
        var count:UInt = 0;
        var good:Bool = false;
        var t:Float = -1;
        var oldTime:Float = -1;

        while (!good && i-- > 0) {
            count++;
            t = baselineTest.run();
            if (t < 0)
                continue;
            var d:Float = Math.abs(t - oldTime);
            good = (oldTime >= 0) && (d / (oldTime + t) * 2 < 0.1 || d < 2);
            oldTime = t;
        }
        baselineTest.iterations = count;
        currentTestSuite.baselineTime = (t < 0 || oldTime < 0) ? -1 : (t + oldTime) / 2;
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
        ", average: " + toFixed(test.average, 3) +
        ", deviation: " + toFixed(test.deviation, 3));
    }

    public function traceTestResult(test:AbstractTest, testSuite:TestSuite):Void {
        var t:Float = ((test.average - testSuite.baselineTime) / testSuite.loops);
        trace("      Result: " + t + " ms per operation");

        if (t < 0) {
            trace("      ERROR: Baseline faster than test case!");
        }
    }

    public static function toFixed(value:Float, precision:UInt):Float {
        return Std.int(value * (Math.pow(10, precision))) / Math.pow(10, precision);
    }

}
