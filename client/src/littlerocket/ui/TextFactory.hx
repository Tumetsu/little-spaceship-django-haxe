package littlerocket.ui;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.display.Font;
import flambe.display.TextSprite;
import littlerocket.Context;
import littlerocket.controllers.RocketStatusFieldControl;
import littlerocket.Assets;

/**
 * A factory class to build different text heavy ui-elements.
 * @author Tuomas Salmi
 */
class TextFactory
{

	public function new() 
	{
		
	}
	
	
	public static function getRocketStatusField(x:Float, y:Float):Entity
	{
		var e:Entity = new Entity();
		var grid:TextGrid = new TextGrid();
		var parentSpr:Sprite = new Sprite();
		e.add(parentSpr);
		parentSpr.setXY(x, y);
		e.add(grid);
		e.add(new RocketStatusFieldControl());
		return e;
	}
	
	/**
	 * A helper function to quickly create new TextSprites
	 * @param	ctx
	 * @param	text
	 * @param	font
	 * @return
	 */
	public static function createText(text:String, font:String):TextSprite
	{
		//create the text
		var f:Font = new Font(Assets.mainPack, font);
		var t:TextSprite = new TextSprite(f, text);
		t.align = TextAlign.Left;
		return t;
		
	}
	
}