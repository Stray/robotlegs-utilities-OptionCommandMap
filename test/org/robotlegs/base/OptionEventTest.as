package org.robotlegs.base {

	import asunit.framework.TestCase;
	
	import flash.events.Event;

	public class OptionEventTest extends TestCase {
		private var instance:OptionEvent;

		public function OptionEventTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new OptionEvent('testEvent');
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is OptionEvent", instance is OptionEvent);
		}
        
		public function testIsEvent():void{
			assertTrue("instance is Event", instance is Event);
		}
        
        public function testCloneReturnsSameEvent():void{
	    	var eventType:String = "testEvent";
			var clone:OptionEvent = instance.clone() as OptionEvent;
			assertTrue("OptionEvent can be cloned to correct class", clone is OptionEvent);
			assertTrue("OptionEvent clone retains event type", clone.type == "testEvent");
		}
		
		public function testEventStrings():void{
		   	assertTrue("OptionEvent.OPTION_1 has correct string", OptionEvent.OPTION_1 == 'OptionEvent.option1');
		   	assertTrue("OptionEvent.OPTION_2 has correct string", OptionEvent.OPTION_2 == 'OptionEvent.option2');
		   	assertTrue("OptionEvent.OPTION_3 has correct string", OptionEvent.OPTION_3 == 'OptionEvent.option3');
		   	assertTrue("OptionEvent.OPTION_4 has correct string", OptionEvent.OPTION_4 == 'OptionEvent.option4');
		   	assertTrue("OptionEvent.OPTION_5 has correct string", OptionEvent.OPTION_5 == 'OptionEvent.option5');
		   	assertTrue("OptionEvent.OPTION_6 has correct string", OptionEvent.OPTION_6 == 'OptionEvent.option6');
		   	assertTrue("OptionEvent.OPTION_7 has correct string", OptionEvent.OPTION_7 == 'OptionEvent.option7');
		   	assertTrue("OptionEvent.OPTION_8 has correct string", OptionEvent.OPTION_8 == 'OptionEvent.option8');
		   	assertTrue("OptionEvent.OPTION_9 has correct string", OptionEvent.OPTION_9 == 'OptionEvent.option9');
		   	assertTrue("OptionEvent.OPTION_10 has correct string", OptionEvent.OPTION_10 == 'OptionEvent.option10');
		   	assertTrue("OptionEvent.OPTION_11 has correct string", OptionEvent.OPTION_11 == 'OptionEvent.option11');
		   	assertTrue("OptionEvent.OPTION_12 has correct string", OptionEvent.OPTION_12 == 'OptionEvent.option12');
		   	assertTrue("OptionEvent.OPTION_13 has correct string", OptionEvent.OPTION_13 == 'OptionEvent.option13');
		   	assertTrue("OptionEvent.OPTION_14 has correct string", OptionEvent.OPTION_14 == 'OptionEvent.option14');
		   	assertTrue("OptionEvent.OPTION_15 has correct string", OptionEvent.OPTION_15 == 'OptionEvent.option15');
		   	assertTrue("OptionEvent.OPTION_16 has correct string", OptionEvent.OPTION_16 == 'OptionEvent.option16');
		   	assertTrue("OptionEvent.OPTION_17 has correct string", OptionEvent.OPTION_17 == 'OptionEvent.option17');
		   	assertTrue("OptionEvent.OPTION_18 has correct string", OptionEvent.OPTION_18 == 'OptionEvent.option18');
		   	assertTrue("OptionEvent.OPTION_19 has correct string", OptionEvent.OPTION_19 == 'OptionEvent.option19');
		   	assertTrue("OptionEvent.OPTION_20 has correct string", OptionEvent.OPTION_20 == 'OptionEvent.option20');
		}

		public function testFailure():void {
			assertTrue("Failing test", true);
		}
		
	}
}