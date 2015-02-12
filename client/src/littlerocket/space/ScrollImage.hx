package littlerocket.space;
import flambe.Component;
import flambe.display.ImageSprite;
import flambe.script.Script;
import flambe.System;
import flambe.animation.AnimatedFloat;

/**
 * This component scrolls the parent's sprites over the screen 
 * continuously.
 * @author Tuomas Salmi
 */
class ScrollImage extends Component
{
	private var sprites:Array<ImageSprite> = new Array();	//sprites to scroll
	private var speed :AnimatedFloat;
	
	public function new(sprs:Array<ImageSprite>, speed:Float) 
	{
		sprites = sprs;
		this.speed = new AnimatedFloat(speed);
	}
	
	override public function onUpdate(dt:Float):Void
	{
		speed.update(dt);
		
		for ( i in 0...sprites.length ) 
		{
			sprites[i].x._ -= dt * speed._;
		}
		
		//this wrapping works only for two sprites. Should probably be generalized to n-sprites. Just a 
		//quick hack.
		if (sprites[0].x._ < -sprites[0].getNaturalWidth())
		{
			//picture 1 has gone out the screen, transfer it to the right
			sprites[0].x._ = sprites[1].x._ + sprites[1].getNaturalWidth();
		}
		
		if (sprites[1].x._ < -sprites[1].getNaturalWidth())
		{
			//picture 1 has gone out the screen, transfer it to the right
			sprites[1].x._ = sprites[0].x._ + sprites[0].getNaturalWidth();
		}
		
	}
	
}