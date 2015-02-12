package littlerocket.controllers;

/**
 * This small class just holds the data of the different planets.
 * @author Tuomas Salmi
 */
class PlanetData
{
	public var distanceFromSun:Float = 0;
	public var retrieving:Bool = false;
	
	public var name:String = "";
	public var description:String = "";
	public var passageDistance:Float = 0;
	public var type:String = "";
	
	public function new(distanceFromSun:Float) 
	{
		this.distanceFromSun = distanceFromSun;
	}
	
}