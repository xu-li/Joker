package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ColorCorrection;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import xu.li.joker.core.IsoScene;
	import xu.li.joker.core.ITexture;
	import xu.li.joker.textures.ColorTexture;
	import xu.li.joker.textures.TextureList;
	
	/**
	 * ...
	 * @author lixu <athenalightenedmypath@gmail.com>
	 */
	[SWF("width=800, height=600")]
	public class Main extends Sprite 
	{
		private var _scene:IsoScene;
		private var _timer:Timer;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_timer = new Timer(1 / 60);
			
			_scene = new IsoScene(stage.stageWidth, stage.stageHeight);
			
			addChild(_scene.getContainer());
		
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			_scene.render(1 / 60);
		}
		
		/**
		 * Debug function 
		 * 
		 * @param	graphic
		 */
		public function debug(graphic:Graphics, texture:ITexture, x:int = 0, y:int = 0):void
		{
			var position:Point = texture.getPosition();
			var bounds:Rectangle = texture.getBounds();
			
			graphic.beginFill(0xff0000);
			graphic.drawCircle(x + position.x, y + position.y, 2);
			graphic.endFill();
			graphic.lineStyle(1, 0x00ff00);
			graphic.drawRect(x + bounds.x, y + bounds.y, bounds.width, bounds.height);
		}
	}
	
}