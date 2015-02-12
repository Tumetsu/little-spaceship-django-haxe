package littlerocket.controllers;
import flambe.Component;
import flambe.Entity;
import littlerocket.communication.RocketData;
import littlerocket.Context;
import littlerocket.Main;
import littlerocket.ui.TextGrid;
import littlerocket.ui.TextFactory;
import EReg;

/**
 * This class controls the data to be shown in the field
 * which lists the velocity, distance etc. Main function is to connect
 * and handle the server signals and update the view accordingly.
 * @author Tuomas Salmi
 */
class RocketStatusFieldControl extends Component
{
	private var grid:TextGrid = null;


	public function new() 
	{
		
	}
	
	override public function onAdded():Void
	{
		grid = owner.get(TextGrid);
		
		//define the texts to the fields:
		grid.dimensions(2, 4);	//set dimension for the grid
		grid.addText(TextFactory.createText("Next destination", "fonts/myriad_white"), 0, 0);
		grid.addText(TextFactory.createText("Jupiter", "fonts/myriad_orange"), 1, 0);
		grid.addText(TextFactory.createText("Estimated travel time", "fonts/myriad_white"), 0, 1);
		grid.addText(TextFactory.createText("12d 17h 23min", "fonts/myriad_orange"), 1, 1);
		grid.addText(TextFactory.createText("Velocity", "fonts/myriad_white"), 0, 2);
		grid.addText(TextFactory.createText("18 km/s", "fonts/myriad_orange"), 1, 2);
		grid.addText(TextFactory.createText("Distance traveled", "fonts/myriad_white"), 0, 3);
		grid.addText(TextFactory.createText("365 424 662 km", "fonts/myriad_orange"), 1, 3);
		
		Main.serverStatus.rocketDataSignal.connect(updateView);
	}
	
	private function updateView(d:RocketData)
	{
		grid.getText(1, 0).text = Std.string(d.nextDestination);
		
		//deprecated for now, string gotten from server
		/*
		//turn seconds to better format
		var minutes:Float = Math.round(d.estimatedTravelTime) / 60;
		var eMinutes:Float = minutes % 60;
		var hours:Float = minutes / 60;
		var eHours:Float = hours % 24;
		var days:Float = hours / 24;	
		var daysI:Int = Math.floor(days);
		var hoursI:Int = Math.floor(eHours);
		var minutesI:Int = Math.floor(eMinutes);			
		grid.getText(1, 1).text = Std.string(daysI + "d " + hoursI + "h " + minutesI + "min");
		*/
		
		//modify the ETA string a bit:
		try {
			var r:EReg = ~/([0-9]*).* ([0-9]*):([0-9]*)/;
			r.match(d.ETAString);
			var eta:String = r.matched(1) + "d  " + r.matched(2) +"h  " + r.matched(3) + "min";
			grid.getText(1, 1).text = eta;
		}
		catch (e : Dynamic)
		{
			try {
				var r:EReg = ~/([0-9]*).*:([0-9]*):([0-9]*)/;
				r.match(d.ETAString);
				var eta:String = r.matched(1) + "h " + r.matched(2) +"min";
				grid.getText(1, 1).text = eta;
			}
			catch (e2:Dynamic) {
				grid.getText(1, 1).text = "Error in time format";
			}
		}
		
		
		var vS:String = Std.string(d.velocity);
		vS = vS.substring(0, vS.indexOf('.', 0)+4);
		grid.getText(1, 2).text = vS +" km/s";
		grid.getText(1, 3).text = Std.string(d.distanceTraveled)  + " km";
	}
	
}