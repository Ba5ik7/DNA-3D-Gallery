package
{
	import flash.display.Sprite;

	import com.wes.ui.PVPhotoXMLCarouselDNA;

	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	
	[SWF(width="1280", height="800", backgroundColor="0x000000", frameRate="35")]
	public class Main extends Sprite{
		
		
		
		private var mc:PVPhotoXMLCarouselDNA = new PVPhotoXMLCarouselDNA();
		
		private var txt:TextField = new TextField();
		
		public function Main() {
			
			// constructor code
			trace("I'm the top CLASS for the Gallery Stage");
			addChild(mc);
			
			var txt:TextField = new TextField();
			txt.wordWrap = true;
			txt.width = 500;
			txt.height = 500;
			txt.multiline = true;
			txt.htmlText= "SOME TEXT";
			
			txt.autoSize = TextFieldAutoSize.CENTER;
			
			
			txt.setTextFormat(new TextFormat(null,18,0xFFFFFF));
			
			txt.antiAliasType = AntiAliasType.ADVANCED;
			
			
			
			addChild(txt);
			
			
		}
		
	}
	
}