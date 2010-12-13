**Design objective**

A commandMap which allows you to map against a common event type, and which automatically cleans up (removing all mappings) once one of the options has been selected and actioned.

**Use case**

*OptionCommandMap* is designed to streamline the following use case:                                 

* A user is offered multiple options
* Based on which option they select, a different command (or combination of commands) should be run
* Once the appropriate command is run, the previous option-command pairings are no longer required

Note: The use case happens repeatedly at runtime, with variations in the options and the commands, but a persistence of the overall pattern - the user is making a choice, and based on that choice a command should be executed. (Note that 'user' could be substituted with an external service or client).

eg:

* A construction-project game pops up with "It's raining frogs! What would you like to do?" with options "Stop work for the day" or "Carry on"
* Depending on which option the user chooses, a different command runs to update models within the game to reflect the user's choice
* Once the user has made their decision, the other option is no longer viable


**Why not just use the ordinary CommandMap?**

You could achieve the above by doing the following mappings:

	commandMap.mapEvent(RainingFrogsEvent.KEEP_WORKING, KeepWorkingCommand, RainingFrogsEvent);
	commandMap.mapEvent(RainingFrogsEvent.STOP_WORKING, StopWorkingCommand, RainingFrogsEvent);
	
but that would result in a lot of bespoke events for each possible option offered to the player.

If we decide to use a common OptionEvent and make mappings at runtime such as:

 	commandMap.mapEvent(OptionEvent.OPTION_A, KeepWorkingCommand, OptionEvent);
	commandMap.mapEvent(OptionEvent.OPTION_B, StopWorkingCommand, OptionEvent);  
	
then we need to also keep unmapping these events, as once an option has been selected, the rest of the mappings (which may be many, there could be several options) need to be unmapped.

The OptionCommandMap is intended to streamline this process and make the cleanup automatic, as well as simplifying the setup.





