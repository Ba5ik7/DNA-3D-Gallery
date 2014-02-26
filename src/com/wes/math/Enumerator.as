package com.wes.math
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Enumerator extends EventDispatcher
	{
		
		public static const UPDATE:String = "update"
		
		private var _items:Array;
		private var _index:int = -1;
		private var _loop:Boolean = false;
		
		public function Enumerator(pItems:Array = null)
		{
			
			super();
			_items = pItems;

		}
		
		//--------------------------------------
		//  GETTERS & SETTERS
		//--------------------------------------
		public function get items():Array{ return _items; }
		public function set items(value:Array):void {_items = value; }
		public function get loop():Boolean{ return _loop; }
		public function set loop(value:Boolean):void {_loop = value; }
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------
		
		public function getNextItem():*
		{
			_index++;
			return enumerate();
		}
		
		public function getPreviousItem():*
		{
			_index--;
			return enumerate();
		}
		
		//--------------------------------------
		//  PRIVATE & PROTECTED METHODS
		//--------------------------------------
		private function enumerate():*
		{
			if (_loop)
			{
				if (_index > _items.length-1)
				{
					_index = 0;
				}else if(_index < 0){
					_index = _items.length -1;
				}
				
			}else{
				if (_index < 0) {
					_index = 0;
				}else if(_index > _items.length-1){
					_index = _items.length-1;
				}
			}
			
			dispatchEvent( new Event(Enumerator.UPDATE) )
			
			return _items[_index];
		}

	}
}