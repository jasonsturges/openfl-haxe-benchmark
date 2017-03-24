OpenFL Haxe Performance Test
============================

Modeled after [Grant Skinner's](http://gskinner.com/blog) ActionScript project [PerformanceTest](http://gskinner.com/blog/archives/2010/02/performancetest.html), this variation is designed for [OpenFL](http://www.openfl.org/) to benchmark segments of Haxe code.

Executing a batch of tests every 50-milliseconds on a Timer, each iteration runs a defined number of loops for multiple samples.  Overhead baseline is removed from the result, and deviation of each iteration is denoted.

### Example: Event Dispatch Test

In the test suite below, one test has been executed over 4-iterations.

    TestSuite: Event Test (Event dispatching operations.)
       Baseline time: 0
       Test: dispatchHandled (Dispatch and handle an event.)
          time: 127, min: 127, max: 127, average: 127, deviation: 0
          time: 125, min: 125, max: 127, average: 126, deviation: 0.01587301587
          time: 124, min: 124, max: 127, average: 125.3333333, deviation: 0.02393617021
          time: 125, min: 124, max: 127, average: 125.25, deviation: 0.02395209581
          Result: 0.00012525 ms per operation

Each iteration executes the function 10,000,000 for a cumulative total of 40,000,000 calls to the function.  This is configurable per test suite.

Each sample of the four iterations are measured - below we see:

- 1<sup>st</sup> sample made 10,000,000 function calls in 127ms
- 2<sup>nd</sup> sample made 10,000,000 function calls in 125ms
- 3<sup>rd</sup> sample made 10,000,000 function calls in 124ms
- 4<sup>th</sup> sample made 10,000,000 function calls in 125ms

Each iteration displays a running average of total time to execute test, also expressing consistency by calculating deviation.

Finally, after all samples of this test have been run, the result of the function call is calculated to take `0.00012525` milliseconds.

In this example, looping the test function incurred immeasurable overhead.  Baseline is calculated and removed from total results to compensate computation time of executing the test loop.


##### Creating Test Suites

Test suites are a collection of multiple tests.  To create a Test Suite, extend `TestSuite`:

    class ExampleTestSuite extends TestSuite {
    }

In your constructor, define properties of the test suite, such as:

- *name* &mdash; Name of this test suite
- *description* &mdash; Description of the this test suite
- *initFunction* &mdash; Function to call before tests of this test suite are executed, to initialize any properties of this class
- *baselineTest* &mdash; Function to measure overhead of looping, or other metrics to remove from total time calculations
- *loops* &mdash; Number of times each test function should loop when be executed.  In this example, each test will execute 10,000,000 times
- *iterations* &mdash; Number of times the test should be run.  In this example, each test will be run 4-times, each time looping 10,000,000 times for a total of 40,000,000 function calls

Example constructor:

        public function new() {
            super();

            name = "Example Test Suite";
            description = "This is an example test suite for multiple tests";
            initFunction = initialize;
            baselineTest = new MethodTest(baseline);
            loops = 10000000;
            iterations = 4;
            tests = [
            ];
        }

If your test suite has local properties, or other initialization that must be performed before running the test suite, place code inside the initialize function:

        public function initialize():Void {
            // Any initialization of the test suite here
        }

Each time the test is run, there may be computational overhead of looping or other tasks which take time.  By executing this code without the test operation, a baseline may be calculated.  That baseline will be removed from final test results.

For example, calculate how much overhead it takes to execute a `for` loop:

        public function baseline():Void {
            for (i in 0 ... loops) {
            }
        }

##### Add Tests to Test Suites

To add tests to your test suite, add a subclass of `AbstractTest` to your `tests` array of your test suite.  For example, to call a method on your test suite, use  `MethodTest`:

        tests = [
            new MethodTest(test1, null, "Test Function 1", 0, 1, "Execute function `test1` from this class"),
            new MethodTest(test2, null, "Test Function 2", 0, 1, "Execute function `test2` from this class")
        ];

Above, two tests are defined that will call `test1()` and `test2()` functions on the test suite.

        public function test1():Void {
            for (i in 0 ... loops) {
                // test operation here
            }
        }

        public function test2():Void {
            for (i in 0 ... loops) {
                // test operation here
            }
        }

This means your "Test Function 1" test will be tested 4-iterations, and each iteration will loop inside the function 10,000,000 times.

Likewise, exactly the same thing will happen for the second test defined: "Test Function 2".

### Altogether your test suite class should look like:

    package tests;

    import performance.model.MethodTest;
    import performance.model.TestSuite;

    class ExampleTestSuite extends TestSuite {

        //------------------------------
        //  properties
        //------------------------------

        // define any fields you need here


        //------------------------------
        //  methods
        //------------------------------

        public function new() {
            super();

            name = "Example Test Suite";
            description = "This is an example test suite for multiple tests";
            initFunction = initialize;
            baselineTest = new MethodTest(baseline);
            loops = 10000000;
            iterations = 4;
                tests = [
                    new MethodTest(test1, null, "Test Function 1", 0, 1, "Execute function `test1` from this class"),
                    new MethodTest(test2, null, "Test Function 2", 0, 1, "Execute function `test2` from this class")
                ];
        }

        // add additional utility methods if needed


        //------------------------------
        //  initialization
        //------------------------------

        public function initialize():Void {
            // Any initialization of the test suite here
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

        public function test1():Void {
            for (i in 0 ... loops) {
                // test operation here
            }
        }

        public function test2():Void {
            for (i in 0 ... loops) {
                // test operation here
            }
        }

    }


### Executing Tests

Currently tests results are traced; therefore, some targets will output results in a terminal whereas targets such as html5 will need to inspect the console.

To execute all tests, call `openfl test` by target, such as:

    $ openfl test mac
    $ openfl test flash
    $ openfl test neko
    $ openfl test html5

Executing one of the examples under the `tests` package, here are the results of the instantiation test suite:

![instantiation](http://labs.jasonsturges.com/openfl/openfl-haxe-performance-test/instantiation.png)

![instantiation-platform](http://labs.jasonsturges.com/openfl/openfl-haxe-performance-test/instantiation-platform.png)

| | Neko | Flash | HTML5 | Mac |
| --- | --- | --- | --- | --- |
| Point | 0.00083550 | 0.00015100 | 0.00001000 | 0.00002175 |
| Rectangle | 0.00112750 | 0.00014650 | 0.00001675 | 0.00002375 | 
| Matrix | 0.00197725 | 0.00015650 | 0.00047350 | 0.00003150 |
| Matrix3D | 0.01145775 | 0.00018775 | 0.00007300 | 0.00019575 |
| Shape | 0.00951150 | 0.00320700 | 0.00125675 | 0.00125450 |
| Sprite | 0.02412375 | 0.00494575 | 0.00178250 | 0.00169400 |
| MovieClip | 0.01653800 | 0.00479000 | 0.00233325 | 0.00161975 |
| Bitmap | 0.01347125 | 0.00702225 | 0.00201800 | 0.00248875 |
| BitmapData | 0.00754875 | 0.01692500 | 0.03907500 | 0.00499725 |


## License

This project is free, open-source software under the [MIT license](LICENSE.md).

Copyright 2015-2017 [Jason Sturges](http://jasonsturges.com)
