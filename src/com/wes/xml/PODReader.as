package com.wes.xml
{
	
	import flash.events.*;
	import flash.net.*;
	
	
	//
	public class PODReader extends EventDispatcher
	{
		
		private var xmlLoader:URLLoader;
		
		public var feed:XML;
		public var episodes:XMLList;
		public var title:String;
		public var description:String;
		
		
		//
		public function PODReader()
		{
			
			xmlLoader = new URLLoader();
			
		}
		
		
		//
		public function load(xmlReq:URLRequest):void
		{
			
			xmlLoader.load(xmlReq);
			
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			
		}
		
		
		
		//
		private function xmlLoaded(event:Event):void
		{
			
			processXML(new XML(xmlLoader.data));
			
		}
		
		
		//
		public function processXML(xmlData:XML):void
		{
			
			feed = xmlData;
			
			episodes = feed..item;
			
			title = feed.channel.title;
			
			description = feed.channel.description;
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
	
}