package com.wes.ui
{

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.VideoStreamMaterial;
	import org.papervision3d.materials.special.Letter3DMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.typography.Font3D;
	import org.papervision3d.typography.Text3D;
	import org.papervision3d.typography.fonts.HelveticaRoman;
	import org.papervision3d.view.BasicView;
	
		

	public class VideoCube extends Cube
	{
		


		private var netConnection:NetConnection;
		private var videoStreamMaterial:VideoStreamMaterial;
		
		private var mat:ColorMaterial = new ColorMaterial(0x444444);
		private var matBack:ColorMaterial = new ColorMaterial(0x333333);
		private var matbottom:ColorMaterial = new ColorMaterial(0x444444);
		private var mattop:ColorMaterial = new ColorMaterial(0x111111);
		private var matleft:ColorMaterial = new ColorMaterial(0x222222);
		private var matright:ColorMaterial = new ColorMaterial(0x222222);
		
		private var ml:MaterialsList = new MaterialsList();
		
		private var video:Video;
		private var netStream:NetStream;
		private var path:String;
		
		private var switchw:Boolean = false;
		
		private var obj:Object = new Object;
		
		private var text3D:Text3D;
        private var textMaterial:Letter3DMaterial;
        private var font3D:Font3D;
		
		
		/*/////////////////////////////////////////////////////////////
		
		
		*/////////////////////////////////////////////////////////////
		public function VideoCube(pathw:String, objw:Object)
		{
			// constructor code
			obj = objw;
			
			var customClient:Object = new Object();
			path = pathw;

			netConnection = new NetConnection();
			netConnection.connect(null);

			netStream = new NetStream(netConnection);
			netStream.client = customClient;
			
			video = new Video();
			video.width = 320;
			video.height = 240;
			video.smoothing = true;
			videoStreamMaterial = new VideoStreamMaterial(video,netStream);
			
			
			ml.addMaterial(matright, "right");
			ml.addMaterial(matbottom, "bottom");
			ml.addMaterial(mattop, "top");
			ml.addMaterial(matleft, "left");
			ml.addMaterial(matBack, "front");
			ml.addMaterial(mat, "back");

			matright.doubleSided = false;
			matright.interactive = true;
			matbottom.doubleSided = false;
			matbottom.interactive = true;
			mattop.doubleSided = false;
			mattop.interactive = true;
			matleft.doubleSided = false;
			matleft.interactive = true;
			matBack.doubleSided = false;
			matBack.interactive = true;
			mat.doubleSided = false;
			mat.interactive = true;
			mat.name = "mat";
			
			videoStreamMaterial.doubleSided = false;
			videoStreamMaterial.interactive = true;
			videoStreamMaterial.name = "video";

			super(ml, 320, 50, 240, 1, 1, 1);
			
			textMaterial = new Letter3DMaterial(0xFFFFFF);
			textMaterial.doubleSided = true;
			font3D = new HelveticaRoman();
			text3D = new Text3D(objw.title.toString(), font3D, textMaterial);
			text3D.y = -175;
			text3D.scale = .65;
			addChild(text3D);
			
			/*var blurFilter:BlurFilter = new BlurFilter(24, 12, 2);
			this.filters = [blurFilter];*/

		}
		
		
		
		/*/////////////////////////////////////////////////////////////
		
		Updater
		*/////////////////////////////////////////////////////////////
		public function update():void
		{
			
			
			
		}
		

		
		/*/////////////////////////////////////////////////////////////
		
		Mouse Events
		*/////////////////////////////////////////////////////////////
		public function over():void
		{

			
		}


		public function out():void
		{

			
		}
		
		
		
		public function click(event:InteractiveScene3DEvent):void
		{
			trace("Click");
			trace(this.obj.title);
			trace(this.obj.discription);
			trace(this.obj.image);

			if(switchw == false){
				
				var t:Timer = new Timer(60, 1);
				t.addEventListener(TimerEvent.TIMER_COMPLETE, function():void{
				
										trace("Im false I'll start playing the video");
										
										switchw = true;
										netStream.play(path);
										video.attachNetStream(netStream);
										
										trace(ml.getMaterialByName("front"));
										
										var color:Number = Math.round(Math.random() * 0xffffff);
										event.displayObject3D.replaceMaterialByName(videoStreamMaterial, 'back');
								   });
				
				t.start();
				
				
			} else {
				
				trace("Im true I'll stop playing the video");
				event.displayObject3D.replaceMaterialByName(mat, 'back');
				
				video.clear();
				netStream.close();
				
				switchw =false;
				
				
				
			}
			
			
			
		}//End of Function
		//////////////////////////////////////////////////////////////////////////////////////////


	}

}