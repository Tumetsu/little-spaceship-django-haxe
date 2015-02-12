package littlerocket.communication;
import flambe.Component;
import flambe.util.Signal1;
import flambe.script.Script;
import flambe.script.Sequence;
import flambe.script.Delay;
import flambe.script.CallFunction;
import flambe.script.Repeat;
import haxe.Json;

/**
 * This class handles the connections to the server. It request's the most recent information
 * through REST-API and dispatches a signal with updated info for other game components to listen
 * to.
 * @author Tuomas Salmi
 */
class ServerStatus extends Component
{
	public var rocketDataSignal:Signal1<RocketData> = new Signal1<RocketData>(); //signal which tells the update values of the Rocket.
	private var prevRocketData:RocketData = null;
	
	private var requestInterval:Float = 1; //how often we request the server. In seconds
	private var requestHandler:RequestHandler = null;
	private var requestInProcess:Bool = false;

	
	private var pushes:Array<Float> = new Array();	//array of pushes done.
	private var pushInProgress:Bool = false;
	
	private var rocketMass:Float = 200;				//GET THIS FROM SERVER!!!!!
	private var localPushes:Int = 0;
	
	public function getHandler():RequestHandler
	{
		return requestHandler;
	}
	
	public function new() 
	{
		prevRocketData = new RocketData();
		//testdata
		prevRocketData.nextDestination = "";
		prevRocketData.distanceTraveled = 0;
		prevRocketData.estimatedTravelTime = 0; 
		prevRocketData.prevEstimatedTravelTime = 0;
		prevRocketData.prevVelocity = 0;
		prevRocketData.velocity = 0;
		prevRocketData.pushes = 0;
		
		requestHandler = new RequestHandler();
		requestHandler.requestCompleteSignal.connect(handleUpdateRequestResults); //listen when the request is finished
		requestHandler.pushCompleteSignal.connect(pushResults); //listen when the request is finished
	}
	
	override public function onAdded():Void
	{
		var script:Script = new Script();
		
		//start the updating loop
		script.run(new Repeat(new Sequence([
		  new Delay(requestInterval),
		  new CallFunction(function () {
				rocketUpdateRequest();
				sendPushRequest();
			}),
		])));
		
		owner.add(script);
	}
	
	/**
	 * This function is called at every second and emits signal containing the updated data of the rocket.
	 */
	private function rocketUpdateRequest():Void
	{
		//trace("emit rocket update signal");
		if (!requestInProcess)
		{
			requestInProcess = true;
			requestHandler.getRocketStatus();
		}
		
	}
	
	/**
	 * Sends a request containing the pushes player made. Called every second unless a request is in
	 * progress, or there is no pushes to be sent.
	 */
	private function sendPushRequest():Void
	{
		if (!pushInProgress && pushes.length > 0)
		{
			requestHandler.postPushes(pushes);
			pushes.splice(0, pushes.length);	//remove old pushes
			pushInProgress = true;
		}
	}
	
	private function pushResults(result:String):Void
	{
		trace("PUSHIN TULOS: " + result);
		pushInProgress = false;
	}
	
	
	
	/**
	 * After server has answered to the request, parse the resulting JSON and
	 * construct new model of the state of the rocket to be emitted to the rest of
	 * the application.
	 * @param	result Json-string
	 */
	private function handleUpdateRequestResults(result:String):Void
	{
		try
		{
			
			requestInProcess = false;
			var d:Dynamic = Json.parse(result);
			var r:RocketData = new RocketData();
			
			if (d.velocity > prevRocketData.velocity - 0.000005)
			{
				r.velocity = d.velocity;
				r.prevVelocity = prevRocketData.prevVelocity;
				r.pushes = d.pushes;
				localPushes = d.pushes;
				//trace("SERVERI VOITTI");
				
			}
			else
			{
				r.velocity = prevRocketData.velocity;	//dismiss server packet and use my velocity. Server should send
														//udpdated speed at the next round.
				r.pushes = localPushes;
				//trace("serveri ei voittanu");
				
			}
			
			r.distanceTraveled = d.distanceTraveled;
			r.distanceFromSun = d.distanceFromSun;
			r.estimatedTravelTime = d.estimatedTravelTime;
			r.ETAString = d.ETAString;
			r.nextDestination = d.nextDestination;
			
			r.distanceToTarget = d.distanceToTarget;
			r.prevDistanceTraveled = prevRocketData.prevDistanceTraveled;
			r.prevEstimatedTravelTime = prevRocketData.prevEstimatedTravelTime;
			prevRocketData = r;
			
			rocketDataSignal.emit(r);
		}
		catch ( unknown : Dynamic )
		{
			trace("Error: " + unknown + " at Rocket update request.");
			requestInProcess = false;
		}

	}
	
	
	
	//increments the rocketdata for test purposes
	private function testUpdateData(data:String):Void
	{
		
		var r:RocketData = new RocketData();
		r.nextDestination = data;
		r.velocity = prevRocketData.prevVelocity + 1;
		r.distanceTraveled = prevRocketData.distanceTraveled + prevRocketData.velocity;
		r.estimatedTravelTime = prevRocketData.prevEstimatedTravelTime - 1;
		r.prevVelocity = prevRocketData.prevVelocity;
		r.prevDistanceTraveled = prevRocketData.prevDistanceTraveled;
		r.prevEstimatedTravelTime = prevRocketData.prevEstimatedTravelTime;
		r.pushes = Math.floor(Math.random() * 5);
		
		//update the data of the previous data to the new one:
		prevRocketData.prevDistanceTraveled = r.distanceTraveled;
		prevRocketData.prevEstimatedTravelTime = r.estimatedTravelTime;
		prevRocketData.prevVelocity = r.velocity;

		rocketDataSignal.emit(r);
		
	}
	
	/**
	 * This function registers a push and adds it to the array to be sent to the server later.
	 * @param	force
	 */
	public function pushRocket(force:Float):Void
	{
		estimateVelocityIncrease(force);
		pushes.push(force);
	}
	
	private function estimateVelocityIncrease(force:Float):Void
	{
		var inc:Float = (force / rocketMass) / 1000.0;
		prevRocketData.velocity += inc;	
		localPushes += 1;
		prevRocketData.pushes = localPushes;
		rocketDataSignal.emit(prevRocketData);		//emit local data to the rest of the program
	}

	
}