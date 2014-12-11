package;

import openfl.display.Sprite;
import performance.controller.PerformanceTest;
import tests.CastTestSuite;
import tests.EventTestSuite;
import tests.FloatTestSuite;
import tests.FunctionInliningTestSuite;
import tests.InstantiationTestSuite;

class Main extends Sprite {

	//------------------------------
	//  model
	//------------------------------

	private var performanceTest:PerformanceTest;

	//------------------------------
	//  lifecycle
	//------------------------------

	public function new () {
		super ();

		performanceTest = PerformanceTest.getInstance();

		performanceTest.enqueueTestSuite(new FloatTestSuite());
		performanceTest.enqueueTestSuite(new CastTestSuite());
		performanceTest.enqueueTestSuite(new FunctionInliningTestSuite());
		performanceTest.enqueueTestSuite(new EventTestSuite());
		performanceTest.enqueueTestSuite(new InstantiationTestSuite());

		performanceTest.runAsynchronous();
	}

}