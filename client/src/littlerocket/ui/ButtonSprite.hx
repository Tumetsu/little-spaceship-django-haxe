package littlerocket.ui;
import flambe.display.ImageSprite;
import flambe.display.Texture;
import flambe.input.PointerEvent;
import flambe.Disposer;
import format.tools.Image;

/**
 * This is a special sprite to show buttons
 * @author Tuomas Salmi
 */
class ButtonSprite extends ImageSprite
{
	private var normalTex:Texture = null;
	private var hoverTex:Texture = null;
	private var pressedTex:Texture = null;
	private var beforeRelease:Texture = null;
	
	public function new(normalTex:Texture, hoverTex:Texture, ?pressedTex:Texture) 
	{
		super(normalTex);
		this.normalTex = normalTex;
		this.hoverTex = hoverTex;
		this.pressedTex = pressedTex;
		
		var disposer:Disposer = new Disposer();
		this.pointerUp.connect(onPointerUp2);
		this.pointerDown.connect(onPointerDown2);
		
		disposer.add(this.pointerOut.connect(onPointerOut));
		disposer.add(this.pointerIn.connect(onPointerIn));
		disposer.add(this.pointerOut.connect(onPointerDown2));
		disposer.add(this.pointerIn.connect(onPointerUp2));
		
		texture = normalTex;
		beforeRelease = normalTex;
	
	}
	
	/**
	 * Change the texture when the user hovers:
	 * @param	event
	 */
	private function onPointerIn(event:PointerEvent):Void
	{
		texture = hoverTex;
		beforeRelease = hoverTex;
	}
	
	/**
	 * Change the texture back when the user doesn't hover anymore.
	 * @param	event
	 */
	private function onPointerOut(event:PointerEvent):Void
	{
		texture = normalTex;
		beforeRelease = normalTex;
	}
	
	private function onPointerDown2(event:PointerEvent):Void
	{
		trace("Nappi alas");
		if (pressedTex != null && texture == hoverTex)
			texture = pressedTex;
	}
	
	private function onPointerUp2(event:PointerEvent):Void
	{
		texture = beforeRelease;
	}
	
}