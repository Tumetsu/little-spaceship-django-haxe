package littlerocket;
import flambe.display.TextSprite;
import flambe.scene.Scene;
import flambe.Entity;
import flambe.scene.Scene;
import flambe.script.Repeat;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import littlerocket.communication.ServerStatus;
import littlerocket.controllers.FlightControl;
import littlerocket.rocket.RocketFactory;
import littlerocket.space.BackgroundFactory;
import littlerocket.ui.ButtonFactory;
import littlerocket.ui.TextFactory;
import littlerocket.ui.ButtonSprite;
import flambe.input.PointerEvent;
import flambe.script.Script;
import flambe.script.CallFunction;
import flambe.script.Sequence;
import flambe.script.AnimateTo;
/**
 * ...
 * @author Tuomas Salmi
 */
class MainScene extends Scene
{

	private var pushForce:Float = 200;
	private var flightControl:FlightControl = null;
	private var loadingText:Entity = null;
	
	public function new() 
	{
		super();
		

	}
	
	override public function onAdded():Void
	{
		//add flightcontrol:
		flightControl = new FlightControl();
		owner.add(flightControl);
		flightControl.initCompleteSignal.connect(afterInit);
		
		//add loading text:
		loadingText = new Entity();
		var spr:TextSprite = TextFactory.createText("Loading...", "fonts/myriad_white");
		spr.setXY(12, System.stage.height - 24);
		loadingText.add(spr);
		
		//fadeinout animation
		var script = new Script();
		script.run(new Repeat(new Sequence([
			new AnimateTo(spr.alpha, 0, 1),
			new AnimateTo(spr.alpha, 1, 1),
		])));
		loadingText.add(script);
		
		owner.addChild(loadingText);
		
	}
	
	/**
	 * After FlightControl has gotten required initialization data from the server, create
	 * rest of the objects.
	 */
	private function afterInit():Void
	{
		trace("INIT DONE");
		loadingText.dispose();
		loadingText = null;
		//add space background
		owner.addChild(BackgroundFactory.getBackground());
		// Add a plane that moves along the screen
		owner.addChild(RocketFactory.getRocket());
		
		//////////////////////////////////////////////////////////////////////////
		///TODO: 
		///LAITA PAREMPAAN PAIKKAAN JA REFAKTOROI!!!!!
		/////////////////////////////////////////////////////////////////////////
		var pushButton:Entity = ButtonFactory.getBigButton("Give me a push!", System.stage.width / 2, System.stage.height - 64, Anchor.Center);
		owner.addChild(pushButton);
		//connect the button to the ServerStatus' function
		pushButton.get(ButtonSprite).pointerDown.connect(function(event:PointerEvent) { 
			trace("CLICK"); 
			Main.serverStatus.pushRocket(pushForce);			//VAIHDA 
			});
		
		
		
		owner.addChild(ButtonFactory.getImageButton(Assets.mainPack.getTexture("ui/solarsystem_button_normal"), Assets.mainPack.getTexture("ui/solarsystem_button_hover"), System.stage.width - 108, 4, Anchor.Left));
		owner.addChild(ButtonFactory.getImageButton(Assets.mainPack.getTexture("ui/ranking_button_normal"), Assets.mainPack.getTexture("ui/ranking_button_hover"), System.stage.width - 56, 4, Anchor.Left));
		
		owner.addChild(TextFactory.getRocketStatusField( 8, 8));
	}
	
	
	
	
}




