package littlerocket.space;
import flambe.Entity;
import littlerocket.Context;
import flambe.display.ImageSprite;
import littlerocket.Assets;

/**
 * Builds an Entity to show the scrolling background image.
 * @author Tuomas Salmi
 */
class BackgroundFactory
{

	public function new() 
	{
		
	}
	
	/**
	 * Get a scrolling space background.
	 * @param	ctx
	 * @return
	 */
	public static function getBackground():Entity
	{
		var e:Entity = new Entity();
		var sprs:Array<ImageSprite> = new Array();
		
		//create two images of the stars to scroll across the screen continuously.
		for ( i in 0...2) 
		{
			var sE:Entity = new Entity();
			var s:ImageSprite = new ImageSprite(Assets.mainPack.getTexture("starspace"));
			s.setXY(s.getNaturalWidth() * i, 0);
			sprs.push(s);
			sE.add(s);
			e.addChild(sE);
		}
		
		var scroller:ScrollImage = new ScrollImage(sprs, 60);
		e.add(scroller);
		
		return e;
		
	}
	
}