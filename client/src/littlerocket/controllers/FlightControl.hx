package littlerocket.controllers;
import flambe.Component;
import flambe.Entity;
import flambe.script.Script;
import flambe.util.Signal0;
import littlerocket.communication.RocketData;
import littlerocket.Main;
import flambe.util.Signal1.Listener1;
import haxe.Json;
import flambe.script.Sequence;
import flambe.script.Delay;
import flambe.script.CallFunction;

/**
 * This class observes the status of the rocket and triggers creation of different objects
 * when it detects something interesting from the rocket's status.
 * @author Tuomas Salmi
 */
class FlightControl extends Component
{
	private var PLANETTRIGGERMARGIN:Float = 180000;
	private var PLANETREMOVEMARGIN:Float = 180000*2;
	private var FoV:Float = 20;	//degrees
	private var objectDistances:Array<PlanetData> = new Array();
	
	public var initCompleteSignal:Signal0 = new Signal0();
	private var timeOutScript:Script = new Script();
	private var requestInterval:Int = 2;

	public function new() 
	{
		
	}
	
	//make a request to the server
	private function getInitData():Void
	{
		Main.serverStatus.getHandler().initRequestCompleteSignal.connect(readInitData).once();
		Main.serverStatus.getHandler().getInitData();
	}
	
	//make a request to the server
	private function getPlanetData(planet:PlanetData):Void
	{
		planet.retrieving = true;
		Main.serverStatus.getHandler().planetRequestCompleteSignal.connect(readPlanetData).once();
		Main.serverStatus.getHandler().getPlanetData(planet);
	}
	
	
	//after request has been completed, read the data and create a new planet entry
	private function readPlanetData(data:String, planet:PlanetData):Void
	{
		try 
		{
			//try to deserialize the json:
			var d:Dynamic = Json.parse(data);		
			planet.name = d.name;
			planet.description = d.description;
			planet.passageDistance = d.passageDistance;
			planet.type = d.type;
			
			trace(planet.name); 
			//TODO: create a planet Entity to the screen to the correct position and with correct size. 
			
		}
		catch ( unknown : Dynamic )
		{
			planet.retrieving = false;	//try again
		}
			
	}
	
	
	
	//handle the data gotten from the server:
	private function readInitData(data:String):Void
	{
		try
		{
			trace("DO INIT");
			//try to deserialize the json:
			var d:Dynamic = Json.parse(data);
			
			//add planet distances to the array:
			for ( i in 0...d.celestialObjects.length ) {
				objectDistances.push(new PlanetData(d.celestialObjects[i].distanceFromSun));
				trace(d.celestialObjects[i].distanceFromSun);
			}	
		}
		catch ( unknown : Dynamic )
		{
			trace("Error: " + unknown + " at Init update request.");
			//make a new request:
			//wait a bit before making a new request
			timeOutScript.run(new Sequence([
			  new Delay(requestInterval),
			  new CallFunction(function () {
					getInitData();
					timeOutScript.dispose();
				}),
			]));
			owner.add(timeOutScript);
			return;
			
		}
		
		
		initCompleteSignal.emit();
	}
	
	override public function onAdded():Void
	{
		
		
		Main.serverStatus.rocketDataSignal.connect(checkStatus);
		getInitData();
	}
	
	/**
	 * When the new status signal arrives, check if there is anything interesting.
	 * @param	d
	 */
	private function checkStatus(d:RocketData):Void
	{
		checkPlanetApproach(d);
	}
	
	
	/**
	 * Check if we are approaching a planet
	 * @param	d
	 * @return
	 */
	private function checkPlanetApproach(d:RocketData):Bool
	{
		for (i in 0...objectDistances.length)
		{
			trace(i);
			if ((objectDistances[i].distanceFromSun < (d.distanceFromSun + PLANETTRIGGERMARGIN)) && (objectDistances[i].distanceFromSun > d.distanceFromSun - PLANETREMOVEMARGIN))
			{
				//we are approaching a planet, so request its information from the server
				if (!objectDistances[i].retrieving)
				{
					trace("APPROACHING PLANET");
					getPlanetData(objectDistances[i]);
				}
			}
		}
		return false;
	}
	
}