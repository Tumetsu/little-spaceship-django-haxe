package littlerocket.communication;
import flambe.util.Signal1;
import haxe.Http;
import haxe.Json;
import flambe.System;
import littlerocket.controllers.PlanetData;
import flambe.util.Signal2.Signal2;

/**
 * ...
 * @author Tuomas Salmi
 */
class RequestHandler
{
	public var requestCompleteSignal:Signal1<String> = new Signal1<String>(); //signal which tells the result of the request
	public var pushCompleteSignal:Signal1<String> = new Signal1<String>(); //signal which tells the result of the request
	public var initRequestCompleteSignal:Signal1<String> = new Signal1<String>(); //signal which tells the result of init
	public var planetRequestCompleteSignal:Signal2<String, PlanetData> = new Signal2<String, PlanetData>(); //signal which tells the result of the request
	
	private var DOMAIN:String = "http://localhost:8000"; //"http://80.240.130.190";
	
	public function new() 
	{

	}
	
	
	public function getRocketStatus():Void
	{
		var urlLoader:Http = new Http(DOMAIN +"/api/rocket/?format=json");//"http://localhost:8000/api/rocket/?format=json");	//
		
		// add parameters
		//urlLoader.addParameter("myVar", "myValue");
		//urlLoader.addParameter("userName", "Mark");
		urlLoader.setHeader('Access-Control-Allow-Origin', '*');
		urlLoader.setHeader("Content-Type", "application/json");
		urlLoader.setHeader("Accept", "application/json");
		
		// callbacks
		urlLoader.onError = function (msg) {requestCompleteSignal.emit(msg);};
		urlLoader.onData = function(data)
		{ 
		   requestCompleteSignal.emit(data);
		   
		}

		// sends to data using GET
		urlLoader.request();

		// sends to data using POST
		//urlLoader.request(true);
	}
	
	public function getInitData():Void
	{
		var urlLoader:Http = new Http(DOMAIN +"/api/init/?format=json");//"http://localhost:8000/api/rocket/?format=json");	//
		
		// add parameters
		urlLoader.setHeader('Access-Control-Allow-Origin', '*');
		urlLoader.setHeader("Content-Type", "application/json");
		urlLoader.setHeader("Accept", "application/json");
		
		// callbacks
		urlLoader.onError = function (msg) {initRequestCompleteSignal.emit(msg);};
		urlLoader.onData = function(data)
		{ 
		   initRequestCompleteSignal.emit(data);
		}

		// sends to data using GET
		urlLoader.request();
	}
	
	public function getPlanetData(planet:PlanetData):Void
	{
		var urlLoader:Http = new Http(DOMAIN +"/api/planetinfo/?format=json");//"http://localhost:8000/api/planetinfo/?format=json");	//
		
		// add parameters
		urlLoader.setHeader('Access-Control-Allow-Origin', '*');
		urlLoader.setHeader("Content-Type", "application/json");
		urlLoader.setHeader("Accept", "application/json");
		urlLoader.setParameter("distanceFromSun", Std.string(planet.distanceFromSun));
		
		// callbacks
		urlLoader.onError = function (msg) {planetRequestCompleteSignal.emit(msg, planet);};
		urlLoader.onData = function(data)
		{ 
		   planetRequestCompleteSignal.emit(data, planet);
		}

		// sends to data using GET
		urlLoader.request();
	}
	
	public function postPushes(pushes:Array<Float>):Void
	{
		var cookie:String = getCookie();
		var urlLoader:Http = new Http(DOMAIN +"/api/push/?format=json"); //"http://localhost:8000/api/push/?format=json"); //
		// add parameters
		var jstr:String = '{ "pushes": [';
		
		for (i in 0...pushes.length)
		{
			jstr += '{ "push": ' + Std.string(pushes[i]) + ' },';
		}
		jstr = jstr.substr(0, jstr.length - 1);	//remove last ","
		jstr += "]}";
		
		trace(jstr);
		urlLoader.setHeader("X-CSRFToken", cookie);					//HACK TO DISABLE CSRF TOKEN. SHOULD BE ENABLED WHEN AUTHENTICATION IS REQUIRED
		urlLoader.setHeader('Access-Control-Allow-Origin', '*');
		urlLoader.setHeader("Content-Type", "application/json");
		urlLoader.setHeader("Accept", "application/json");

		urlLoader.setPostData(jstr);
		
		// callbacks
		urlLoader.onError = function (msg) {pushCompleteSignal.emit(msg);};
		urlLoader.onData = function(data)
		{ 
		   pushCompleteSignal.emit(data);  
		}

		// sends to data using POST
		urlLoader.request(true);
		
	}
	
	/**
	 * This gets a Cookie to be used in the request to get past CSRF protection. It is gotten
	 * from javascript function which is stored in csfrcookie.js. Code of that file is from
	 * https://docs.djangoproject.com/en/dev/ref/contrib/csrf/
	 * @return
	 */
	private function getCookie():String
	{
		var param:Array<Dynamic> = new Array();
		param.push("csrftoken");
		return System.external.call('getCookie',param);
	}
	
	
}