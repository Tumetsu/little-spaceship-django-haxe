package littlerocket.communication;

/**
 * Just a container which holds all the data required to update values
 * related to the rocket. Given through signal from ServerStatus class.
 * @author Tuomas Salmi
 */
class RocketData
{
	public var nextDestination:String = "";
	public var estimatedTravelTime:Float = 0;
	public var velocity:Float = 0;
	public var distanceTraveled:Float = 0;
	public var pushes:Float = 0;
	public var distanceToTarget:Float = 0;
	public var distanceFromSun:Float = 0;
	
	public var prevEstimatedTravelTime:Float = 0;
	public var prevVelocity:Float = 0;
	public var prevDistanceTraveled:Float = 0;
	public var prevDistanceToTarget:Float = 0;
	public var ETAString:String = "";
	
	public function new() 
	{
		
	}
	
}