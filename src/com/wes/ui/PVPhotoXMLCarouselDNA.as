/*
*  PAPER    ON   ERVIS  NPAPER ISION  PE  IS ON  PERVI IO  APER  SI  PA
*  AP  VI  ONPA  RV  IO PA     SI  PA ER  SI NP PE     ON AP  VI ION AP
*  PERVI  ON  PE VISIO  APER   IONPA  RV  IO PA  RVIS  NP PE  IS ONPAPE
*  ER     NPAPER IS     PE     ON  PE  ISIO  AP     IO PA ER  SI NP PER
*  RV     PA  RV SI     ERVISI NP  ER   IO   PE VISIO  AP  VISI  PA  RV3D
*  ______________________________________________________________________
*  papervision3d.org + blog.papervision3d.org + osflash.org/papervision3d
*
*Wes Dusell
*-suck my balls
*/

//PaperCloud

package com.wes.ui
{
	
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.special.ParticleField;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	//import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	//import org.papervision3d.objects.special.ParticleField;
	import org.papervision3d.view.BasicView;

	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.materials.ColorMaterial;

	

	
	public class PVPhotoXMLCarouselDNA extends BasicView
	{
		
		private var planes:Array = new Array();
		private var iwhich:*;
		
		private var planeContainer:DisplayObject3D;
		private var plane:VideoCube;
		
		private var urlReq:URLRequest = new URLRequest("xml/main.xml");
		private var urlLoad:URLLoader;
		private var l:Loader;
		
		private var xml:XML;
		private var xmlList:XMLList;
		
		private var bmd:BitmapData;
		
		private var star:ParticleField;
		
		private var k:int;
		private var counter:int;
		
		private var planeByContainer:Dictionary = new Dictionary();
		
		
		//var img = addChild(new Bitmap(new BackC(0,0)));
		
		/*private var mat:BitmapMaterial = new BitmapMaterial(new BackC(0,0), true);
		private var matBack:ColorMaterial=new ColorMaterial(0x333333);
		private var matbottom:ColorMaterial = new ColorMaterial(0x444444);;
		private var mattop:ColorMaterial = new ColorMaterial(0x111111);
		private var matleft:ColorMaterial = new ColorMaterial(0x222222);
		private var matright:ColorMaterial = new ColorMaterial(0x222222);
		
		private var ml:MaterialsList = new MaterialsList();*/
		
		
		//_Con
		/////////////////////////////////////////////////////////////////////////////////////		
		public function PVPhotoXMLCarouselDNA()
		{
			
			trace("hello");
			super(800, 600, true, true);
			/*matright.doubleSided = true;
			matbottom.doubleSided = true;
			mattop.doubleSided = true;
			matleft.doubleSided = true;
			matBack.doubleSided = true;
			mat.doubleSided = true;
			
			ml.addMaterial(matright, "right");
			ml.addMaterial(matbottom, "bottom");
			ml.addMaterial(mattop, "top");
			ml.addMaterial(matleft, "left");
			ml.addMaterial(mat, "front");
			ml.addMaterial(mat, "back");
			
			
			var c:Cube = new Cube(ml, 10000, 10000, 10000, 5, 5, 5);
			planeContainer.addChild(c);
			*/
			star = new ParticleField(new ParticleMaterial(0x00FF00, 1, ParticleMaterial.SHAPE_CIRCLE), 1000);
			scene.addChild(star);
			planeContainer = new DisplayObject3D();
			scene.addChild(planeContainer);
			
			
			
			camera.extra =
				{
					goPosition:new DisplayObject3D(),
					goTarget:new DisplayObject3D()
				};
			
			camera.extra.goPosition.copyPosition(camera);
			
			urlLoad = new URLLoader();
			urlLoad.addEventListener(Event.COMPLETE, xmlLoaded);
			urlLoad.load(urlReq);

		}
		/////////////////////////////////////////////////////////////////////////////////////

		
		
		//MouseEvents
		/////////////////////////////////////////////////////////////////////////////////////
		private function planeOver(event:InteractiveScene3DEvent):void
		{
			var flipPlane:VideoCube = event.displayObject3D as VideoCube;
			flipPlane.over();
			
		}
		
		private function planeOut(event:InteractiveScene3DEvent):void
		{
			var flipPlane:VideoCube = event.displayObject3D as VideoCube;
			flipPlane.out();
			
		}
		
		private function planeClick(event:InteractiveScene3DEvent):void
		{
			
			
				var flipPlane:VideoCube = event.displayObject3D as VideoCube;
				flipPlane.click(event);
			
			var target:DisplayObject3D = new DisplayObject3D();
			
			target.copyTransform( flipPlane );
			target.moveBackward( 300);
			
			camera.extra.goPosition.copyPosition( target );
			camera.extra.goTarget.copyPosition( flipPlane );
			
		}
		/////////////////////////////////////////////////////////////////////////////////////
		
		
		
		//XmlLoad and set to Bitmap
		/////////////////////////////////////////////////////////////////////////////////////
		private function xmlLoaded(event:Event):void
		{
			
			xml = new XML(event.target.data);
			xmlList = new XMLList(xml.photo);
			
			for(var i:int = 0; i<xmlList.length(); i++)
			{
				var obj:Object = new Object();
				obj.title = xmlList[i].title.toString();
				obj.discription = xmlList[i].discription.toString();
				obj.image = xmlList[i].image.toString();
				
				
				plane = new VideoCube(xmlList[i].vid.toString(), obj);
				plane.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, planeOver);
				plane.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, planeOut);
				plane.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, planeClick);
				plane.yaw((380/xmlList.length())* i);
				plane.moveForward(-800);
				plane.moveUp(150 * i);
				planeContainer.addChild(plane);
				planes.push(plane);

			}
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			//surfaceHeight = -event.target.height -40;
			
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		
		
		

		//Updater for planes:Array to allow Mouse Events to work
		////////////////////////////////////////////////////////////////////////////////////
		public function updatePlanes():void
		{
			for each(var plane:VideoCube in planes)
			{
				plane.update();
			}
			
		}	
		////////////////////////////////////////////////////////////////////////////////////
		
		
		
		//TICKER / LOOP
		////////////////////////////////////////////////////////////////////////////////////
		private function enterFrame(event:Event):void
		{
			
			updatePlanes();
			update3D();
			
		}
		
		private function update3D():void
		{
			var target:DisplayObject3D = camera.target;
			var goPosition:DisplayObject3D = camera.extra.goPosition;
			var goTarget:DisplayObject3D = camera.extra.goTarget;
			
			camera.x -= (camera.x - goPosition.x) /6;
			camera.y -= (camera.y - goPosition.y) /6;
			camera.z -= (camera.z - goPosition.z) /6;
			
			target.x -= (target.x - goTarget.x) /6;
			target.y -= (target.y - goTarget.y) /6;
			target.z -= (target.z - goTarget.z) /6;
			
			var paper:DisplayObject3D;
			
			for(iwhich in planes)
			{
				paper = planes[iwhich] as DisplayObject3D;
				
				var goto:DisplayObject3D = paper;
				
				paper.x -= (paper.x - goto.x) / 6;
				paper.y -= (paper.y - goto.y) / 6;
				paper.z -= (paper.z - goto.z) / 6;
				
				paper.rotationX -= (paper.rotationX - goto.rotationX) /6;
				paper.rotationY -= (paper.rotationY - goto.rotationY) /6;
				paper.rotationZ -= (paper.rotationZ - goto.rotationZ) /6;
			}
			
			singleRender();
			
		}
		////////////////////////////////////////////////////////////////////////////////////
	
	}
}