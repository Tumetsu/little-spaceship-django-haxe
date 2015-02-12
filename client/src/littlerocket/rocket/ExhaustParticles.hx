package littlerocket.rocket;
import flambe.Component;
import flambe.display.EmitterMold;
import flambe.display.EmitterSprite;
import flambe.display.ImageSprite;
import flambe.display.BlendMode;
import littlerocket.communication.RocketData;
import littlerocket.communication.ServerStatus;
import flambe.util.Signal1.Signal1;
import littlerocket.Main;


/**
 * ...
 * @author Tuomas Salmi
 */
class ExhaustParticles extends Component
{
	private var emitter:EmitterSprite = null;
	private var emitterMold:EmitterMold = null;
	private var exhaustTimer:Float = 0;
	
	public function new() 
	{
		
	}
	
	override public function onAdded():Void
	{
		trace("partikkelit pyöriin!");
		emitterMold = new EmitterMold(Assets.mainPack, "particles/exhaust");  //new EmitterMold(Assets.mainPack, "particles/particle");
		emitter = new EmitterSprite(emitterMold);

		emitter.emitX._ = 0;
		emitter.emitY._ = owner.parent.get(ImageSprite).getNaturalHeight() / 2;
		emitter.blendMode = BlendMode.Add;
		owner.add(emitter);
		emitter.enabled = false;
		
		Main.serverStatus.rocketDataSignal.connect(exhaust);	//listen data coming from server
	}
	
	/**
	 * This function is called when client receives data from server. If there have happened pushes, create fumes.
	 * @param	data
	 */
	private function exhaust(data:RocketData):Void
	{
		if (data.pushes > 0)
		{
			var num:Int = Std.int(data.pushes * 10);
			
			if (num > 100)
			{
				num = 100;
			}
			
			emitter.enabled = true;
			exhaustTimer = 1;
			emitter.maxParticles = num;
		}
	}
	
	override public function onUpdate(dt:Float):Void
	{
		if (exhaustTimer > 0)
		{
			exhaustTimer -= dt;
		}
		else
		{
			emitter.enabled = false;
		}
	}
	
}