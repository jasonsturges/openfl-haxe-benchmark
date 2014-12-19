package;

import openfl.display.Sprite;
import performance.controller.PerformanceTest;
import tests.BitwiseTestSuite;
import tests.CastTestSuite;
import tests.EventTestSuite;
import tests.FloatTestSuite;
import tests.FunctionInliningTestSuite;
import tests.FunctionScopeTestSuite;
import tests.GraphicsTestSuite;
import tests.IndexerTestSuite;
import tests.InstantiationTestSuite;
import tests.LoopHoistingTestSuite;
import tests.LoopTestSuite;

class Main extends Sprite {

    //------------------------------
    //  model
    //------------------------------

    private var performanceTest:PerformanceTest;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        performanceTest = PerformanceTest.getInstance();

        performanceTest.enqueueTestSuite(new FloatTestSuite());
        performanceTest.enqueueTestSuite(new BitwiseTestSuite());
        performanceTest.enqueueTestSuite(new CastTestSuite());
        performanceTest.enqueueTestSuite(new FunctionScopeTestSuite());
        performanceTest.enqueueTestSuite(new FunctionInliningTestSuite());
        performanceTest.enqueueTestSuite(new EventTestSuite());
        performanceTest.enqueueTestSuite(new LoopTestSuite());
        performanceTest.enqueueTestSuite(new LoopHoistingTestSuite());
        performanceTest.enqueueTestSuite(new IndexerTestSuite());
        performanceTest.enqueueTestSuite(new InstantiationTestSuite());
        performanceTest.enqueueTestSuite(new GraphicsTestSuite());

        performanceTest.runAsynchronous();
    }

}