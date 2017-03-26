package;

import openfl.display.Sprite;
import benchmark.core.Benchmark;
import tests.BitwiseTestSuite;
import tests.CastTestSuite;
import tests.CollectionTestSuite;
import tests.EventTestSuite;
import tests.FloatTestSuite;
import tests.FunctionInliningTestSuite;
import tests.FunctionOverheadTestSuite;
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

    private var _benchmark:Benchmark;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        _benchmark = new Benchmark();

        _benchmark.enqueueTestSuites([
            new PropertyTestSuite(),
            new FloatTestSuite(),
            new BitwiseTestSuite(),
            new TypeCheckingTestSuite(),
            new CastTestSuite(),
            new MapTestSuite(),
            new CollectionTestSuite(),
            new FunctionOverheadTestSuite(),
            new FunctionInliningTestSuite(),
            new EventTestSuite(),
            new LoopTestSuite(),
            new LoopHoistingTestSuite(),
            new IndexerTestSuite(),
            new KeyExistsTestSuite(),
            new InstantiationTestSuite(),
            new GraphicsTestSuite()
        ]);

        _benchmark.runAsynchronous();
    }

}