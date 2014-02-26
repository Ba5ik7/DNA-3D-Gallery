package com.wes.utils{
	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.LineScaleMode;
	import flash.display.Stage;
	import flash.text.*;
	
	public class Tooltip{
		
		private static var _list:Array=new Array();
		private static var _root_clip:MovieClip;
		private static var _stage:Stage;
		private static var _tooltip:MovieClip
		private static var _active:DisplayObject;
		private static var _styleSheet:StyleSheet;
		private static var margin:Number=10 // distance to mouse
		
		public function Tooltip(){
		  
		  throw("Do not create an intance of this class.");
		
		}
		
		public static function setRoot(s:MovieClip):void{
			_root_clip=s;
			_stage=_root_clip.stage;
		}
		
		public static function addTooltip(ob:DisplayObject,t:String):void{
			var found:Boolean=false
			for(var i:int=0;i<_list.length;i++){
				 if(ob==_list[i][0]){
					found=true;
				}
			}
			if(!found){
				_list.push([ob,t]);
				ob.addEventListener(MouseEvent.MOUSE_OVER,doTooltip);
				ob.addEventListener(MouseEvent.MOUSE_OUT,removeTooltip);
				//ob.addEventListener(MouseEvent.MOUSE_DOWN,removeTooltip);
			}
		}
		
		public static function fireRemoveTooltip():void{
		if(_tooltip!=null){
				_root_clip.removeChild(_tooltip);
				_tooltip=null;
			}
		}
		
		public static function deleteTooltip(ob:DisplayObject){
			ob.removeEventListener(MouseEvent.MOUSE_OVER,doTooltip);
			ob.removeEventListener(MouseEvent.MOUSE_OUT,removeTooltip);
			ob.removeEventListener(MouseEvent.MOUSE_DOWN,removeTooltip);
			for(var i:int=0;i<_list.length;i++){
				 if(ob==_list[i][0]){
					_list.splice(i,1);
				}
			}
			
		}
		public static function deleteAllTooltips(){
			for(var i:int=0;i<_list.length;i++){
				 _list[i][0].removeEventListener(MouseEvent.MOUSE_OVER,doTooltip);
				 _list[i][0].removeEventListener(MouseEvent.MOUSE_OUT,removeTooltip);
				 _list[i][0].removeEventListener(MouseEvent.MOUSE_DOWN,removeTooltip);
			}
			_list=new Array()
			if(_tooltip!=null){
				_root_clip.removeChild(_tooltip);
				_tooltip=null;
			}
		}
		
		private static function doTooltip(ev:MouseEvent):void{
			 _active=ev.target as DisplayObject;
			 var t:String;
			 //find text
			 for(var i:int=0;i<_list.length;i++){
				 if(_active==_list[i][0]){
					 t=_list[i][1];
					 break;
				}
			}
			
			_active.removeEventListener(MouseEvent.MOUSE_OVER,doTooltip);
			//_active.addEventListener(MouseEvent.MOUSE_MOVE,updateTooltipPos)
			
			var text_txt:TextField=new TextField();
			
			text_txt.antiAliasType=flash.text.AntiAliasType.ADVANCED;
			text_txt.selectable=false;
			text_txt.embedFonts=false;
			text_txt.multiline = true;
			text_txt.wordWrap = true;
			
			
			var textFormat:TextFormat=new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.size = 24;
			textFormat.font = "Verdana";
			
			text_txt.width = 460;
			text_txt.height = 500;
			text_txt.defaultTextFormat = textFormat;
			text_txt.styleSheet = getStyleSheet();
			text_txt.text=t;
			//text_txt.autoSize=TextFieldAutoSize.LEFT;

			
			_tooltip=new MovieClip();
			_root_clip.addChild(_tooltip);
            
            //STAY WAY FROM MOUSE
			_tooltip.x=_root_clip.mouseX+margin
			_tooltip.y=_root_clip.mouseY+margin
			
			_tooltip.x = 10;
			_tooltip.y = 630;
			_tooltip.addChild(text_txt);
			
		}
		
		static public function getStyleSheet():StyleSheet{
		      var css:StyleSheet;
		      if(_styleSheet==null){
		          css = new StyleSheet();
		      }else{
		          css=_styleSheet;
		      }
			return css;
        }
        
        static public function setStyleSheet(css:StyleSheet):void{
            _styleSheet=css;
        }
		
		private static function updateTooltipPos(ev:MouseEvent):void{
			
			/*if(_root_clip.mouseX+_tooltip.width>920){
				_tooltip.x=_root_clip.mouseX-_tooltip.width;
			}*/
			
			if(_root_clip.mouseX+_tooltip.width>480){
				_tooltip.x=_root_clip.mouseX-_tooltip.width;
				_tooltip.y=_root_clip.mouseY+margin;
			}
			if(_root_clip.mouseX+_tooltip.width<480){
			//STAY WAY FROM MOUSE
			_tooltip.x=_root_clip.mouseX+margin;
			_tooltip.y=_root_clip.mouseY+margin;
			}
		
		}
		
		private static function removeTooltip(ev:MouseEvent):void{
			//trace("remove tool tip")
			if(_tooltip!=null){
				_root_clip.removeChild(_tooltip);
				_tooltip=null;
			}
			_active.addEventListener(MouseEvent.MOUSE_OVER,doTooltip);
			_active.removeEventListener(MouseEvent.MOUSE_MOVE,updateTooltipPos);
		}
		
	}
	
}