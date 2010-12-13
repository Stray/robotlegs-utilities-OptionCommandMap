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
		
		public function test_registering_one_command_against_one_option_the_command_fires_in_response_to_the_option_event():void {
			assertTrue("Registering one command against one option the command fires in response to the option event -> not implemented", false);
		}
		
		public function test_registering_one_command_against_one_option_the_command_doesnt_fire_in_response_to_different_option_event():void {
			assertTrue("Registering one command against one option the command doesnt fire in response to different option event -> not implemented", false);
		}
		
		public function test_one_command_does_not_fire_again_when_event_is_repeated():void {
			assertTrue("One command does not fire again when event is repeated -> not implemented", false);
		}
		
		public function test_two_commands_registered_against_one_option_both_fire():void {
			assertTrue("Two commands registered against one option both fire -> not implemented", false);
		}
		
		public function test_unused_options_are_unmapped_after_an_option_fires():void {
			assertTrue("Unused options are unmapped after an option fires -> not implemented", false);
		}
		
		public function test_unmapping_all_options_commands_not_executed():void {
			assertTrue("Unmapping all options commands not executed -> not implemented", false);
		}
		
		
	}
}