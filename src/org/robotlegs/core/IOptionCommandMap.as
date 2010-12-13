package org.robotlegs.core {
		
	import org.robotlegs.core.ICommandMap;

	public interface IOptionCommandMap extends ICommandMap {

		function mapToOption(optionNumber:uint, commandClass:Class):void;
		
		function hasCommandForOption(optionNumber:uint):Boolean;
		
		function unmapAllOptions():void;
	}
}