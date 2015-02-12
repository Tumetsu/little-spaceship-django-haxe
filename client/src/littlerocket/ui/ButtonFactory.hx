package littlerocket.ui;
import flambe.display.Font;
import flambe.display.TextSprite;
import flambe.display.Texture;
import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.input.PointerEvent;
import littlerocket.Context;
import littlerocket.Assets;


 enum Anchor {
        Left;
        Center;
        Right;
    }
/**
 * This class is used to create all kinds of button like Entities to be added to the game. There is function
 * for each different button. 
 * @author Tuomas Salmi
 */
class ButtonFactory
{
	
	
	public function new() 
	{
		
	}
	
	public static function getBigButton(text:String, x:Float, y:Float, anchor:Anchor):Entity
	{
		var button:Entity = new Entity();	
		var buttonSpr:ButtonSprite = new ButtonSprite(Assets.mainPack.getTexture("ui/bigbutton_normal"), 
														Assets.mainPack.getTexture("ui/bigbutton_hover"), 
														Assets.mainPack.getTexture("ui/bigbutton_click"));
		
		//test signals for button.
		//buttonSpr.pointerOut.connect(function(event:PointerEvent) { trace("out"); } );
		//buttonSpr.pointerIn.connect(function(event:PointerEvent) { trace("in"); } );
		buttonSpr.pointerUp.connect(function(event:PointerEvent) { trace("up"); } );
		
		//create the text
		var f:Font = new Font(Assets.mainPack, "fonts/myriad_white");
		var t:TextSprite = new TextSprite(f, text);
		t.align = TextAlign.Center;
		t.setAnchor(0, t.getNaturalHeight() / 2);
		t.setXY(buttonSpr.x._ + buttonSpr.getNaturalWidth() / 2, buttonSpr.y._ + buttonSpr.getNaturalHeight() / 2);
		button.add(buttonSpr);

		var e:Entity = new Entity();
		e.add(t);
		button.addChild(e);
		buttonSpr.setXY(x, y);
		
		//anchor the button properly:
		if (anchor == Center)
		{
			buttonSpr.centerAnchor();
		}
		else if (anchor == Right)
		{
			buttonSpr.setAnchor(buttonSpr.getNaturalWidth(), 0);
		}
		
		return button;
	}
	
	/**
	 * Used to create buttons which are made made from images.
	 * @param	normalTex
	 * @param	hoverTex
	 * @param	x
	 * @param	y
	 * @param	anchor
	 */
	public static function getImageButton(normalTex:Texture, hoverTex:Texture, x:Float, y:Float, anchor:Anchor)
	{
		var button:Entity = new Entity();	
		var buttonSpr:ButtonSprite = new ButtonSprite(normalTex, hoverTex);
		button.add(buttonSpr);
		buttonSpr.setXY(x, y);
		//anchor the button properly:
		if (anchor == Center)
		{
			buttonSpr.centerAnchor();
		}
		else if (anchor == Right)
		{
			buttonSpr.setAnchor(buttonSpr.getNaturalWidth(), 0);
		}
		
		return button;
	}
	
}