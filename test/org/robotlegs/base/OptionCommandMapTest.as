package org.robotlegs.base {

	import asunit.framework.TestCase;
	import org.robotlegs.base.OptionCommandMap;

	public class OptionCommandMapTest extends TestCase {
		private var instance:OptionCommandMap;

		public function OptionCommandMapTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new OptionCommandMap();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is OptionCommandMap", instance is OptionCommandMap);
		}

		public function testFailure():void {
			assertTrue("Failing test", true);
		}
	}
}