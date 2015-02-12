package littlerocket.rocket;
import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.System;
import littlerocket.Assets;


/**
 * This class is used to manufacture an Entity which will represent
 * the main rocket. Having a Factory for one Entity may seem a bit overkill, but
 * I missed a place to isolate the rocket related code.
 * @author Tuomas Salmi
 */
class RocketFactory
{

	public function new() 
	{
		
	}
	
	/**
	 * Build an Entity holding the Rocket and return it to be added to
	 * the parent Entity
	 * @param	ctx
	 * @return
	 */
	public static function getRocket():Entity
	{
		var rocket:Entity = new Entity();
        var sprite = new ImageSprite(Assets.mainPack.getTexture("rocket"));
		sprite.centerAnchor();
        sprite.x._ = System.stage.width / 2;
		sprite.y._ = System.stage.height / 2;
        //plane.y.animateTo(200, 6);
		rocket.add(sprite);
		var pe:Entity = new Entity();
		rocket.addChild(pe);
		pe.add(new ExhaustParticles());
		
		
		return rocket;
	}
}