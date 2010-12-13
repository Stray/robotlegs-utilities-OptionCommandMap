package org.robotlegs.core {
		
	import org.robotlegs.core.ICommandMap;

	public interface IOptionCommandMap extends ICommandMap {

		mapToOption(optionNumber:uint, commandClass:Class):void;
		
		unmapAllOptions();
	}
}