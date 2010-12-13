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

**Usage**  

Raw usage:

    optionCommandMap.mapOption(1, DoSomethingCommand);
	optionCommandMap.mapOption(2, DoSomethingElseCommand);
  
  
**Usage in a more interesting use case**

Imagine your game regularly presents the user with randomly selected dilemmas. The dilemmas have consequences, which are captured by commands (deduct some money, increase health, reduce probability of something else happening later etc).

The dilemmas are many, and their configuration is determined elsewhere, such that you have a RandomDilemmaGenerator which simply fires a DilemmaGeneratedEvent with a DilemmaVO which contains a vo capturing the question, the option titles and the consequence command classes.

The DilemmaGeneratedEvent is wired to a ConfigureDilemmaCommand, perhaps like this:

	[Inject]
	public var dilemmaEvent:DilemmaGeneratedEvent; 
	
	[Inject]
	public var optionCommandMap:IOptionCommandMap;
	
	public override function execute():void
	{
		var dilemmaVO:DilemmaVO = dilemmaEvent.dilemmaVO;
		var options:Vector.<DilemmaOptionVO> = dilemmaVO.options;
		
		var iLength:uint = options.length;
		for(var i:int=0; i<iLength; i++)
		{
			var optionNumber:uint = options[i].id;
			var optionConsequence:Class = options[i].consequenceCommandClass;
			optionCommandMap.mapOption(optionNumber, optionConsequence);
		}
	}
	
Elsewhere, the same event is picked up by a view mediator

	protected function dilemmaGeneratedHandler(e:DilemmaGeneratedEvent):void
	{
		// assumes the view send the option ID back when a decision is made by the user
		view.dilemmaDecisionSignal.addOnce(decisionHandler);
		// assumes a view that knows how to get the question and option button names from this vo
		view.showDilemma(e.dilemmaVO);
	}
	
	protected function decisionHandler(decisionID:uint):void
	{
		var optionChosen:String = "OPTION_" + decisionID.toString();
		var evt:OptionEvent = new OptionEvent(OptionEvent[optionChosen]);
		dispatch(evt);
	}
     

And that's it. Your individual consequence Commands don't know or care about cleaning up the unneeded other Commands that applied to other options.
                         

**Incorporating OptionCommandMap into your robotlegs project** 

You just need to instantiate and map it in your context - either early in startup, or by overriding the mapInjections context method:

	override protected function mapInjections():void
	{
		super.mapInjections();
		injector.mapValue(IOptionCommandMap, new OptionCommandMap(eventDispatcher, injector, reflector));
	}
	
Then just inject against IOptionCommandMap in your other Commands.    
                       

**Compatibility with robotlegs versions**

This util has been tested against robotlegs versions 1.0 and 1.4 - it should work for any. By simply including the 3 classes in the source of your project you can ensure it compiles against the same version of robotlegs that you're using.
                                                                                                  

**Wot no swc** 

Truth is, I can't get the damn thing to build a swc without also pulling in the robotlegs classes it extends, which would break compatibility with other versions of robotlegs. If you are a swc wizard, please fork and build a swc and share it.