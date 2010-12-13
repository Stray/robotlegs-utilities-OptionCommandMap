package org.robotlegs.base {

	import asunit.errors.AssertionFailedError;     
	import asunit.framework.TestCase;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import mockolate.errors.VerificationError;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.stub;
   	import mockolate.verify;
	import org.hamcrest.core.anything;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.strictlyEqualTo;
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.OptionCommandMap;
	import org.robotlegs.core.ICommandMap;  
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.IOptionCommandMap;
	import org.robotlegs.core.IReflector;
	import org.robotlegs.base.OptionEvent;

	public class OptionCommandMapTest extends TestCase implements ICommandReporter {
		private var optionCommandMap:OptionCommandMap;
        private var injector:IInjector;
		private var eventDispatcher:EventDispatcher;
		private var _reportedCommands:Array;
		
		public function OptionCommandMapTest(methodName:String=null) {
			super(methodName)
		}

		override public function run():void{
			var mockolateMaker:IEventDispatcher = prepare(IMediatorMap, ICommandMap);
			mockolateMaker.addEventListener(Event.COMPLETE, prepareCompleteHandler);
		}

		private function prepareCompleteHandler(e:Event):void{
			IEventDispatcher(e.target).removeEventListener(Event.COMPLETE, prepareCompleteHandler);
			super.run();
		}
        
		public function reportCommand(commandClass:Class):void
		{
			_reportedCommands.push(commandClass);
		}

		override protected function setUp():void {
			super.setUp();
			_reportedCommands = [];
			injector = new SwiftSuspendersInjector();
			var reflector:IReflector = new SwiftSuspendersReflector();  
			eventDispatcher = new EventDispatcher();
			injector.mapValue(IEventDispatcher, eventDispatcher);
			injector.mapValue(DisplayObjectContainer, new Sprite());
			injector.mapValue(IMediatorMap, nice(IMediatorMap));
			injector.mapValue(ICommandMap, nice(ICommandMap));
			injector.mapValue(ICommandReporter, this);
			injector.mapValue(IInjector, injector);
			
			optionCommandMap = new OptionCommandMap(eventDispatcher, injector, reflector);
		}

		override protected function tearDown():void {
			super.tearDown();
			optionCommandMap = null;
		}

		public function testInstantiated():void {
			assertTrue("optionCommandMap is OptionCommandMap", optionCommandMap is OptionCommandMap);
		}
		
		public function test_implements_IOptionCommandMap():void {
			assertTrue("Implements IOptionCommandMap", optionCommandMap is IOptionCommandMap);
		}
		                                                                            
		public function testFailure():void {
			assertTrue("Failing test", true);
		}
		
		public function test_registering_one_command_against_one_option_the_command_fires_in_response_to_the_option_event():void {
			optionCommandMap.mapOption(1, SampleCommandA);                     
			dispatchOption(1);
			assertEqualsArraysIgnoringOrder("received the correct command", [SampleCommandA], _reportedCommands);
		}
		
		public function test_registering_one_command_against_one_option_the_command_doesnt_fire_in_response_to_different_option_event():void {
			optionCommandMap.mapOption(1, SampleCommandA);
			dispatchOption(2);
			assertEqualsArraysIgnoringOrder("wrong commands not received", [], _reportedCommands);
		}
		
		public function test_one_command_does_not_fire_again_when_event_is_repeated():void {
			optionCommandMap.mapOption(1, SampleCommandA);                     
			dispatchOption(1);
			assertEqualsArraysIgnoringOrder("received the correct command", [SampleCommandA], _reportedCommands);
			_reportedCommands = [];
			dispatchOption(1);
			assertEqualsArraysIgnoringOrder("command not received twice", [], _reportedCommands);
		}
		
		public function test_two_commands_registered_against_one_option_both_fire():void {
			optionCommandMap.mapOption(1, SampleCommandA);                     
			optionCommandMap.mapOption(1, SampleCommandB);                     
			dispatchOption(1);
			assertEqualsArraysIgnoringOrder("received the correct commands", [SampleCommandA, SampleCommandB], _reportedCommands);
		}
		
		public function test_unused_options_are_unmapped_after_an_option_fires():void {
			optionCommandMap.mapOption(1, SampleCommandA);                     
			optionCommandMap.mapOption(2, SampleCommandB);                     
			optionCommandMap.mapOption(3, SampleCommandC);                     
			dispatchOption(1);
			_reportedCommands = [];
			dispatchOption(2);
			dispatchOption(3);
			assertEqualsArraysIgnoringOrder("commands not received for other options", [], _reportedCommands);
		}
		
		public function test_unmapping_all_options_commands_not_executed():void {
			optionCommandMap.mapOption(1, SampleCommandA);                     
			optionCommandMap.mapOption(2, SampleCommandB);                     
			optionCommandMap.mapOption(3, SampleCommandC);
			optionCommandMap.unmapAllOptions();                     
			dispatchOption(1);
			dispatchOption(2);
			dispatchOption(3);
			assertEqualsArraysIgnoringOrder("commands not received for unmapped options", [], _reportedCommands);		
		}
		
		public function test_hasCommandForOption_returns_true_after_wiring_and_before_firing_only():void {
			assertFalse("before wiring, hasCommandForOption returns false", optionCommandMap.hasCommandForOption(2));
			optionCommandMap.mapOption(2,SampleCommandB);
			assertTrue("HasCommandForOption returns true after wiring and before firing", optionCommandMap.hasCommandForOption(2));
			dispatchOption(2);
			assertFalse("after firing, hasCommandForOption returns false", optionCommandMap.hasCommandForOption(2));
		}
		
		public function test_optionTypeByNumber_returns_correct_values():void {
			assertEquals("Returns correct value for 1", OptionEvent.OPTION_1, optionCommandMap.optionTypeByNumber(1));
			assertEquals("Returns correct value for 10", OptionEvent.OPTION_10, optionCommandMap.optionTypeByNumber(10));
			assertEquals("Returns correct value for 5", OptionEvent.OPTION_5, optionCommandMap.optionTypeByNumber(5));
			assertEquals("Returns correct value for 17", OptionEvent.OPTION_17, optionCommandMap.optionTypeByNumber(17));
		}
		
		
		private function dispatchOption(optionID:uint):void
		{
			var optionLookup:String = "OPTION_" + optionID.toString();
			var optionEvent:OptionEvent = new OptionEvent(OptionEvent[optionLookup]);
			eventDispatcher.dispatchEvent(optionEvent);
		}
		
	}
}