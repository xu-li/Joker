package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.ColorCorrection;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
		private var _debugSprite:Sprite;
		private var _texture:TextureList;
		private var _bitmapData:BitmapData;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			
			_bitmapData = new BitmapData(800, 600, false, 0);
			var bitmap:Bitmap = new Bitmap(_bitmapData);
			addChild(bitmap);
			
			
			_texture = new TextureList();
			_texture.setPosition(100, 100);
			var colorTexture1:ColorTexture = new ColorTexture(0xff0000, 32, 32);
			colorTexture1.setPosition(50, 50);
			_texture.addTexture(colorTexture1);
			
			
			var colorTexture2:ColorTexture = new ColorTexture(0xff0000, 32, 32);
			//colorTexture.setPosition( -50, -50);
			_texture.addTexture(colorTexture2);
			
			_texture.render(_bitmapData, 0, 0);
			
			
			_debugSprite = new Sprite();
			addChild(_debugSprite);
			
			debug(_debugSprite.graphics, _texture, 0, 0);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			var texture:ITexture = null;
			if (_texture.isHit(e.localX - 100, e.localY - 100))
			{
				for each (texture in _texture.getTextures())
				{
					ColorTexture(texture).setColor(0x0000ff);
				}
			}
			else
			{
				for each (texture in _texture.getTextures())
				{
					ColorTexture(texture).setColor(0xff0000);
				}
			}
			
			_bitmapData.floodFill(0, 0, 0);
			_texture.render(_bitmapData, 0, 0);
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