package org.robotlegs.base 
{
	
	import org.robotlegs.base.CommandMap;
	import flash.events.IEventDispatcher;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IReflector;
	import org.robotlegs.core.IOptionCommandMap;
	
	public class OptionCommandMap extends CommandMap implements IOptionCommandMap
	{
		
		public function OptionCommandMap(eventDispatcher:IEventDispatcher, injector:IInjector, reflector:IReflector) 
		{
			super(eventDispatcher, injector, reflector);
		}
		
		//---------------------------------------
		// IOptionCommandMap Implementation
		//---------------------------------------

		//import org.robotlegs.core.IOptionCommandMap;
		public function mapToOption(optionNumber:uint, commandClass:Class):void
		{
			var optionLookup:String = "OPTION_" + optionNumber.toString();
			var optionType:String = OptionEvent[optionLookup];
			mapEvent(optionType, commandClass, OptionEvent, true);
		}

		public function hasCommandForOption(optionNumber:uint):Boolean
		{
			return false;
		}

		public function unmapAllOptions():void
		{
			
		}

		
		 
	}
}