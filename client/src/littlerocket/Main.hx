package littlerocket;

import flambe.display.Sprite;
import flambe.Entity;
import flambe.scene.Scene;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.Log;
import flambe.util.Logger.LogLevel;
import flambe.scene.Director;
import flambe.math.FMath;
import flambe.math.Rectangle;
import littlerocket.communication.ServerStatus;
import littlerocket.Assets;

class Main
{
	static private var director:Director = new Director();
	static private var mainEntity:Entity;
	static private var ctx:Context;
	static public var serverStatus:ServerStatus = null;
	
    private static function main ()
    {
		trace(DateTools.seconds(1000));
		Log.log(LogLevel.Info, "KLSAHSHKLJAHS");
        // Wind up all platform-specific stuff
        System.init();
		mainEntity = new Entity();
		mainEntity.add(new Sprite());
		System.stage.resize.connect(onResize);
		
		
        // Load up the compiled pack in the assets directory named "bootstrap"
        var manifest = Manifest.fromAssets("content");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack)
    {
		Assets.mainPack = pack;
		ctx = new Context(pack);
		
        // Add a solid color background
        var background = new FillSprite(0x000, System.stage.width, System.stage.height);
        //System.root.addChild(new Entity().add(background));
		
		//add Director
		System.root.add(director);
		
		
		//add main scene
		serverStatus = new ServerStatus();
		mainEntity.add(new MainScene());
		mainEntity.add(serverStatus);
		mainEntity.add(background);
		director.unwindToScene(mainEntity);	//go to main view of rocket.
		
		
    }
	
	public static function onResize()
	{
		trace("resize....");
		// iPhone 5 as target dimension
		var targetWidth = 640; 
		var targetHeight = 480;

		// Specifies that the entire application be scaled for the specified target area while maintaining the original aspect ratio.
		var scale = FMath.min(System.stage.width / targetWidth, System.stage.height / targetHeight);
		if (scale > 1) scale = 1; // You could choose to never scale up.

		// re-scale and center the sprite of the container to the middle of the screen.
		mainEntity.get(Sprite)
			.setScale(scale)
			.setXY((System.stage.width - targetWidth * scale) / 2, (System.stage.height - targetHeight * scale) / 2);

		// You can even mask so you cannot look outside of the container
		//mainEntity.get(Sprite).scissor = new Rectangle(0, 0, targetWidth, targetHeight);
	}
}
