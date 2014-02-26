package com.wes.flickr
{
	
	import flash.events.*;
	import flash.net.*;
	
	
	//
	public class Search extends EventDispatcher
	{
		
		public var info:URLVariables;
		public var feed:XML;
		
		private var req:URLRequest;
		private var loader:URLLoader = new URLLoader;


		
		//
		public function Search()
		{
			
			
			
		}
		
		
		//
		public function search(searchStr:String)
		{
			
			req = new URLRequest("http://api.flickr.com/services/feeds/photos_public.gne?format=rss2");
			
			info = new URLVariables();
			
			info.format = "rss_200";
			
			info.tags = searchStr;
			
			info.data = info;
			
			loader.load(req);
			
			loader.addEventListener(Event.COMPLETE, dataLoaded);
			
		}
		
		
		//
		private function dataLoaded(event:Event):void
		{
			
			feed = new XML(loader.data);
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
	}
	
}