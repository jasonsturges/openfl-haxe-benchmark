package;

import openfl.display.Sprite;
import benchmark.controller.PerformanceTest;
import tests.BitwiseTestSuite;
import tests.CastTestSuite;
import tests.EventTestSuite;
import tests.FloatTestSuite;
import tests.FunctionInliningTestSuite;
import tests.FunctionScopeTestSuite;
import tests.GraphicsTestSuite;
import tests.IndexerTestSuite;
import tests.InstantiationTestSuite;
import tests.KeyExistsTestSuite;
import tests.LoopHoistingTestSuite;
import tests.LoopTestSuite;
import tests.MapTestSuite;
import tests.PropertyTestSuite;
import tests.TypeCheckingTestSuite;

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

        performanceTest.enqueueTestSuites([
            new PropertyTestSuite(),
            new FloatTestSuite(),
            new BitwiseTestSuite(),
            new TypeCheckingTestSuite(),
            new CastTestSuite(),
            new MapTestSuite(),
            new FunctionScopeTestSuite(),
            new FunctionInliningTestSuite(),
            new EventTestSuite(),
            new LoopTestSuite(),
            new LoopHoistingTestSuite(),
            new IndexerTestSuite(),
            new KeyExistsTestSuite(),
            new InstantiationTestSuite(),
            new GraphicsTestSuite()
        ]);

        performanceTest.runAsynchronous();
    }

}